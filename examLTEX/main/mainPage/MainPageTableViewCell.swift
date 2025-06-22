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
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.6196078658, green: 0.6196078658, blue: 0.6196078658, alpha: 1)
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    private var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        self.selectionStyle = .none
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
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
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
    }
    
    private func setDada(_ post: Post) {
        self.titleLabel.text = post.title
        self.descriptionLabel.text = post.text
        self.dateLabel.text = post.date?.toDate()
        if let image = post.image {
            #warning("не понял, какой урл брать, поэтому закрыл картинки")
            let urlSting = "http://l-tech.ru" + image
            ImageLoader.shared.loadImage(urlString: urlSting) { [weak self] image in
                guard let self else { return }
                DispatchQueue.main.async {
                    if let image {
                        self.itemImageView.image = image
                    } else {
                        self.itemImageView.image = UIImage(systemName: "sun.snow.circle.fill")
                    }
                }
            }
        }
    }
}
