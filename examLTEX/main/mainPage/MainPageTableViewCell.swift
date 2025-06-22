//
//  MainPageTableViewCell.swift
//  examLTEX
//
//  Created by vacwin on 22.06.2025.
//

import Foundation
import UIKit
class MainPageTableViewCell: UITableViewCell {
    static let identifier = "MainPageTableViewCellIdentifier"
    //MARK: - properties
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    private var itemImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    //MARK: - overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
        self.dateLabel.text = nil
        self.itemImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - setup
    final func setup(with post: Post) {
        self.setDada(post)
    }
    
    private func setupViews() {
        self.contentView.addSubview(self.itemImageView)
        self.contentView.addSubview(self.stackView)
        self.setupStack()
    }
    
    private func setupStack() {
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.descriptionLabel)
        self.stackView.addArrangedSubview(self.dateLabel)
    }
    
    private func setupConstraints() {
        self.itemImageView.translatesAutoresizingMaskIntoConstraints = false
        self.itemImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        self.itemImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        self.itemImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.itemImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.leadingAnchor.constraint(equalTo: self.itemImageView.trailingAnchor, constant: 16).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.itemImageView.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -16).isActive = true
        
        let imgBottom = itemImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -16)
        imgBottom.priority = .defaultHigh
        imgBottom.isActive = true
    }
    
    private func setDada(_ post: Post) {
        self.titleLabel.text = post.title
        self.descriptionLabel.text = post.text
        self.dateLabel.text = post.date
    }
}
