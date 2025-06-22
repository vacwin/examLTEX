//
//  FavoriteViewController.swift
//  examLTEX
//
//  Created by vacwin on 20.06.2025.
//

import Foundation
import UIKit
class FavoriteViewController: UIViewController {
    private var workInProgressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Экран находится в разработке 🥹"
        label.lineBreakMode = .byWordWrapping
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWorkInProgressLabel()
    }
    
    private func setupWorkInProgressLabel() {
        self.view.addSubview(self.workInProgressLabel)
        self.workInProgressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        self.workInProgressLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        self.workInProgressLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}
