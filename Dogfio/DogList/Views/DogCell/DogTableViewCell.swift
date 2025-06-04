//
//  DogTableViewCell.swift
//  Dogfio
//
//  Created by Jonathan Lopez on 03/06/25.
//

import UIKit

final class DogTableViewCell: UITableViewCell {

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        view.clipsToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let dogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .textPrimary
        label.textAlignment = .left
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .textSecondary
        label.numberOfLines = 0
        return label
    }()

    private let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .textPrimary
        return label
    }()

    private let arrowButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        button.setImage(UIImage(systemName: "arrow.right", withConfiguration: config), for: .normal)
        button.tintColor = .lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        //selectionStyle = .none
        clipsToBounds = false
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup
    private func setupViews() {
        contentView.addSubview(cardView)
        cardView.addSubview(dogImageView)
        cardView.addSubview(textStack)
        cardView.addSubview(arrowButton)

        textStack.addArrangedSubview(nameLabel)
        textStack.addArrangedSubview(descriptionLabel)
        textStack.addArrangedSubview(ageLabel)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            dogImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: -10),
            dogImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            dogImageView.widthAnchor.constraint(equalToConstant: 80),
            dogImageView.heightAnchor.constraint(equalToConstant: 80),

            textStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            textStack.leadingAnchor.constraint(equalTo: dogImageView.trailingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(lessThanOrEqualTo: arrowButton.leadingAnchor, constant: -12),

            arrowButton.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            arrowButton.widthAnchor.constraint(equalToConstant: 24),
            arrowButton.heightAnchor.constraint(equalToConstant: 24),

            ageLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -12)
        ])
    }

    // MARK: Public
    func configure(dog: DogInfoResponse) {
        nameLabel.text = dog.dogName
        descriptionLabel.text = dog.description
        ageLabel.text = "Almost \(dog.age ?? 0) years"
        dogImageView.image = nil

        dogImageView.loadImage(from: dog.image, placeholder: UIImage(named: "placeholder"))
    }
}
