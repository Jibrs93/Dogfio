//
//  DogDatailViewController.swift
//  Dogfio
//
//  Created by Jonathan Lopez on 03/06/25.
//

import UIKit

final class DogDetailViewController: UIViewController {

    private let dog: DogInfoResponse

    init(dog: DogInfoResponse) {
        self.dog = dog
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let dogImageView = UIImageView()
    private let nameLabel = UILabel()
    private let ageLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let ownerCard = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F8F8F8")
        setupViews()
        configureContent()
    }

    private func setupViews() {
        dogImageView.translatesAutoresizingMaskIntoConstraints = false
        dogImageView.contentMode = .scaleAspectFit
        view.addSubview(dogImageView)

        nameLabel.font = .boldSystemFont(ofSize: 24)
        nameLabel.textColor = .textPrimary

        ageLabel.font = .systemFont(ofSize: 16)
        ageLabel.textColor = .textSecondary
        ageLabel.textAlignment = .right

        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .textSecondary
        descriptionLabel.numberOfLines = 0

        let nameAgeStack = UIStackView(arrangedSubviews: [nameLabel, ageLabel])
        nameAgeStack.axis = .horizontal
        nameAgeStack.distribution = .equalSpacing
        nameAgeStack.translatesAutoresizingMaskIntoConstraints = false

        let descriptionCard = UIView()
        descriptionCard.backgroundColor = .white
        descriptionCard.layer.cornerRadius = 20
        descriptionCard.translatesAutoresizingMaskIntoConstraints = false
        descriptionCard.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(nameAgeStack)
        view.addSubview(descriptionCard)
        view.addSubview(ownerCard)

        // Layout
        NSLayoutConstraint.activate([
            dogImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            dogImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dogImageView.widthAnchor.constraint(equalToConstant: 200),
            dogImageView.heightAnchor.constraint(equalToConstant: 200),

            nameAgeStack.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 20),
            nameAgeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameAgeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            descriptionCard.topAnchor.constraint(equalTo: nameAgeStack.bottomAnchor, constant: 20),
            descriptionCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            descriptionLabel.topAnchor.constraint(equalTo: descriptionCard.topAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionCard.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionCard.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionCard.bottomAnchor, constant: -16),

        ])
    }

    private func configureContent() {
        nameLabel.text = dog.dogName
        ageLabel.text = "\(dog.age ?? 0) years"
        descriptionLabel.text = dog.description
        dogImageView.image = nil

        dogImageView.loadImage(from: dog.image, placeholder: UIImage(named: "placeholder"))
    }
}
