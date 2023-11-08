//
//  CollectionNFTCell.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 01.11.2023.
//

import Kingfisher
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
    
    private let iconNFT: UIImageView = {
         let view = UIImageView()
         view.clipsToBounds = true
         view.layer.cornerRadius = 12
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 2
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
   lazy private var basketButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
       button.setImage(A.Icons.basket.image.withRenderingMode(.alwaysTemplate), for: .normal)
       button.tintColor = A.Colors.blackDynamic.color
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .bold17
        label.text = ""
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.font = .medium10
        label.text = ""
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(A.Icons.favouriteInactive.image, for: .normal)
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Public properties
    var viewModel: CollectionNFTCellViewModelProtocol?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(viewModel: CollectionNFTCellViewModelProtocol) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price.replacingOccurrences(of: ".", with: ",") + " ETH"
        iconNFT.kf.setImage(with: URL(string: viewModel.images[0]))
        setupStarsOnStackView(rating: Int(viewModel.rating) ?? 0)
        viewModel.fetchProfileLikes() { [weak self] in
            if viewModel.profileLikes.contains(viewModel.id) {
                DispatchQueue.main.async {
                    self?.likeButton.setImage(A.Icons.favouriteActive.image, for: .normal)
                }
            } else {
                DispatchQueue.main.async {
                    self?.likeButton.setImage(A.Icons.favouriteInactive.image, for: .normal)
                }
            }
        }
        
        viewModel.fetchProfileNfts() { [weak self] in
            if viewModel.profileNfts.contains(String(viewModel.id)) {
                DispatchQueue.main.async {
                    self?.basketButton.setImage(
                        A.Icons.inactiveBasket.image.withRenderingMode(.alwaysTemplate),
                        for: .normal
                    )
                }
            } else {
                DispatchQueue.main.async {
                    self?.basketButton.setImage(
                        A.Icons.basket.image.withRenderingMode(.alwaysTemplate),
                        for: .normal
                    )
                }
            }
        }
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
    
    private func setupStarsOnStackView(rating: Int) {
        if stackView.arrangedSubviews.isEmpty {
            for _ in 1...rating {
                let starActive = UIImageView(image: A.Icons.starActive.image)
                stackView.addArrangedSubview(starActive)
            }
            
            if rating < 5 {
                for _ in rating...4 {
                    let star =  UIImageView(image: A.Icons.star.image.withRenderingMode(.alwaysTemplate))
                    star.tintColor = A.Colors.lightGrayDynamic.color
                    stackView.addArrangedSubview(star)
                }
            }
        }
    }
    
    @objc private func likeButtonTapped() {
        viewModel?.likeButtonTapped()
    }
    
    @objc private func basketButtonTapped() {
        viewModel?.basketButtonTapped()
   }
}
