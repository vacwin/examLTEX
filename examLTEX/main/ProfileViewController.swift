//
//  ProfileViewController.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
import UIKit
class ProfileViewController: UIViewController {
    //MARK: - properties
    private var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.backgroundColor = #colorLiteral(red: 0.0438188687, green: 0.5168788433, blue: 1, alpha: 1)
        button.heightAnchor.constraint(equalToConstant: 54).isActive = true
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    //MARK: - setup
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        self.setupConstraints()
    }
    //MARK: - UI
    private func setupConstraints() {
        let safe = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(self.logoutButton)
        self.logoutButton.leadingAnchor.constraint(equalTo: safe.leadingAnchor).isActive = true
        self.logoutButton.trailingAnchor.constraint(equalTo: safe.trailingAnchor).isActive = true
        self.logoutButton.centerYAnchor.constraint(equalTo: safe.centerYAnchor).isActive = true
        
        self.logoutButton.addTarget(
            self,
            action: #selector(self.onLogutButton),
            for: .touchUpInside
        )
    }
    //MARK: - actions
    @objc private func onLogutButton() {
        debugPrint(1391238173, "logout")
    }
}
