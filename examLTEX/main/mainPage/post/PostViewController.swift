//
//  PostViewController.swift
//  examLTEX
//
//  Created by vacwin on 22.06.2025.
//

import Foundation
import UIKit
class PostViewController: UIViewController {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.text = "Здесь"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Могла бы быть информация о посте"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.setupViews()
        self.setupContraints()
    }
    
    private func setupViews() {
        self.view.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.descriptionLabel)
    }
    
    private func setupContraints() {
        let safe = self.view.safeAreaLayoutGuide
        self.stackView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16).isActive = true
    }
}
