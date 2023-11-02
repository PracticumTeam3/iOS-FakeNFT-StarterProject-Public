//
//  CollectionNFTCell.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 01.11.2023.
//

import UIKit

final class CollectionNFTCell: UICollectionViewCell {
    // MARK: - Private properties
    private let containerView: UIView = {
         let view = UIView()
        view.backgroundColor = A.Colors.whiteDynamic.color
         view.layer.cornerRadius = 12
         view.layer.masksToBounds = true
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
    
    private let iconNFT: UIView = {
         let view = UIView()
         view.backgroundColor = .systemBlue
         view.layer.cornerRadius = 12
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let basketButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(A.Icons.basket.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = A.Colors.blackDynamic.color
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .bold17
        label.text = "Stella"
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.font = .medium10
        label.text = "1,78ETH"
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(A.Icons.favouriteInactive.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure() {
        
    }
    
    // MARK: - Private methods
    private func addSubviews() {
        contentView.addSubview(containerView)
        contentView.addSubview(iconNFT)
        contentView.addSubview(basketButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(likeButton)
        stackView.addArrangedSubview(UIImageView(image: A.Icons.starActive.image))
        stackView.addArrangedSubview(UIImageView(image: A.Icons.starActive.image))
        stackView.addArrangedSubview(UIImageView(image: A.Icons.starActive.image))
        stackView.addArrangedSubview(UIImageView(image: A.Icons.star.image))
        stackView.addArrangedSubview(UIImageView(image: A.Icons.star.image))
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            iconNFT.topAnchor.constraint(equalTo: containerView.topAnchor),
            iconNFT.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            iconNFT.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            iconNFT.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            stackView.topAnchor.constraint(equalTo: iconNFT.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            basketButton.topAnchor.constraint(equalTo: iconNFT.bottomAnchor, constant: 24),
            basketButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            basketButton.heightAnchor.constraint(equalToConstant: 40),
            basketButton.widthAnchor.constraint(equalToConstant: 40),
            nameLabel.topAnchor.constraint(equalTo: iconNFT.bottomAnchor, constant: 25),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            priceLabel.topAnchor.constraint(equalTo: iconNFT.bottomAnchor, constant: 51),
            priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            likeButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            likeButton.heightAnchor.constraint(equalToConstant: 42),
            likeButton.widthAnchor.constraint(equalToConstant: 42)
            
        ])
    }
    
}
