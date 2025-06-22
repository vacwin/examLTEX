//
//  MainPageViewController.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
import UIKit
class MainPageViewController: UIViewController {
    //MARK: - properties
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(
            MainPageTableViewCell.self,
            forCellReuseIdentifier: MainPageTableViewCell.identifier
        )
        table.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        return table
    }()
    private var refreshButton: UIButton!
    private var sortButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        button.setTitle("Sotr", for: .normal)
        return button
    }()
    private let syncQueue = DispatchQueue(
        label: "com.exam.getPosts.syncQueue",
        attributes: .concurrent
    )
    private var _posts: [Post] = []
    private var posts: [Post] {
        var tempPosts: [Post] = []
        self.syncQueue.sync {
            tempPosts = self._posts
        }
        return tempPosts
    }
    //MARK: - overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    //MARK: - setup
    private func setup() {
        self.setupConsraints()
        self.setTable()
        self.getPosts()
    }
    
    private func setupConsraints() {
        let safe = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(self.sortButton)
        self.sortButton.translatesAutoresizingMaskIntoConstraints = false
        self.sortButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16).isActive = true
        self.sortButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16).isActive = true
        self.sortButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.sortButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.sortButton.bottomAnchor, constant: 16).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -16).isActive = true
        
        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    //MARK: - network
    private func getPosts() {
        RequestManager.shared.getPosts { posts, error in
            guard let posts else { return }
            self.setPosts(posts)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setPosts(_ posts: [Post]) {
        self.syncQueue.async(flags: .barrier) {
            self._posts = posts
        }
    }
}

extension MainPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainPageTableViewCell.identifier,
            for: indexPath
        ) as? MainPageTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(
            with: self.posts[indexPath.row]
        )
        return cell
    }
}

extension MainPageViewController: UITableViewDelegate {
    
}
