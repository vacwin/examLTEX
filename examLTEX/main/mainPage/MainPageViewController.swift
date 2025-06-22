//
//  MainPageViewController.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
import UIKit
enum SortedCase: String {
    case byDefault = "По умолчанию"
    case byDate = "По дате"
}

class MainPageViewController: UIViewController {
    //MARK: - properties
    private var refreshTimer: Timer?
    private var sortedCase: SortedCase = .byDefault {
        didSet {
            self.sortLabel.text = self.sortedCase.rawValue
        }
    }
    private var tableView: UITableView = {
        let table = UITableView()
        table.register(
            MainPageTableViewCell.self,
            forCellReuseIdentifier: MainPageTableViewCell.identifier
        )
        table.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        return table
    }()
    private var sortView: UIView = {
        let sortView = UIView()
        sortView.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return sortView
    }()
    private var sortLabel: UILabel = {
        let sortLabel = UILabel()
        sortLabel.text = "По умолчанию"
        sortLabel.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        return sortLabel
    }()
    private let syncQueue = DispatchQueue(
        label: "com.exam.getPosts.syncQueue",
        attributes: .concurrent
    )
    private var defaultSortedPosts: [Post] = []
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let refreshTimer {
            refreshTimer.invalidate()
            self.refreshTimer = nil
        }
    }
    //MARK: - setup
    private func setup() {
        self.setupConsraints()
        self.setupTimer()
        self.setTable()
        self.setupRefreshButton()
        self.setupSortView()
        self.getPosts()
    }
    
    private func setupConsraints() {
        let safe = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(self.sortView)
        self.sortView.translatesAutoresizingMaskIntoConstraints = false
        self.sortView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16).isActive = true
        self.sortView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16).isActive = true
        self.sortView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.sortView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.sortView.bottomAnchor, constant: 16).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -16).isActive = true
        
        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setupRefreshButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(self.didTapOnRefrseshButton)
        )
    }
    
    private func setupSortView() {
        self.sortLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sortView.addSubview(self.sortLabel)
        self.sortLabel.leadingAnchor.constraint(equalTo: self.sortView.leadingAnchor).isActive = true
        self.sortLabel.topAnchor.constraint(equalTo: self.sortView.topAnchor).isActive = true
        self.sortLabel.bottomAnchor.constraint(equalTo: self.sortView.bottomAnchor).isActive = true
        self.sortLabel.widthAnchor.constraint(equalToConstant: 76).isActive = true
        
        let arrowImageView = UIImageView()
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.sortView.addSubview(arrowImageView)
        arrowImageView.topAnchor.constraint(equalTo: self.sortView.topAnchor).isActive = true
        arrowImageView.trailingAnchor.constraint(equalTo: self.sortView.trailingAnchor).isActive = true
        arrowImageView.bottomAnchor.constraint(equalTo: self.sortView.bottomAnchor).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        arrowImageView.image = UIImage(named: "arrow.down.app.fill")
     
        self.sortView.addGestureRecognizer(
            self.setSortGestureRecognizer()
        )
    }
    //MARK: - timer
    private func setupTimer() {
        if let refreshTimer {
            self.refreshTimer = nil
            refreshTimer.invalidate()
        }
        
        self.refreshTimer = Timer.scheduledTimer(
            timeInterval: 200,
            target: self,
            selector: #selector(self.didTapOnRefrseshButton),
            userInfo: nil,
            repeats: true
        )
    }
    //MARK: - network
    private func getPosts() {
        RequestManager.shared.getPosts { posts, error in
            guard let posts else { return }
            self.defaultSortedPosts = posts
            self.setPosts(posts)
        }
    }
    
    private func setPosts(_ posts: [Post]) {
        self.syncQueue.async(flags: .barrier) {
            self._posts = posts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func sortPosts(by sortCase: SortedCase) {
        let tempSorted: [Post]
        switch sortCase {
        case .byDefault:
            tempSorted = self.defaultSortedPosts
        case .byDate:
            tempSorted = self.defaultSortedPosts.sorted { $0.date ?? "0.1" > $1.date ?? "0.2"}
        }
        self.setPosts(tempSorted)
    }
    
    private func setSortGestureRecognizer() -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(onSortButtonTapped)
        )
        return tap
    }
    
    private func setupActionSheet() -> UIAlertController {
        let sheet = UIAlertController(
            title: "Сортировка",
            message: nil,
            preferredStyle: .actionSheet
        )
        return sheet
    }
    
    private func setupActionsForSheet(for sortCase: SortedCase) -> UIAlertAction {
        let action = UIAlertAction(
            title: sortCase.rawValue,
            style: .default) { _ in
                self.sortPosts(by: sortCase)
            }
        return action
    }
    
    //MARK: - actions
    @objc private func didTapOnRefrseshButton() {
        self.getPosts()
    }
    
    @objc private func onSortButtonTapped() {
        let sheet = self.setupActionSheet()
        let cases: [SortedCase] = [.byDefault, .byDate]
        cases.forEach { sortedCase in
            sheet.addAction(self.setupActionsForSheet(for: sortedCase))
        }
        sheet.addAction(
            UIAlertAction(
                title: "Отмена",
                style: .cancel
            )
        )
        self.present(sheet, animated: true)
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
