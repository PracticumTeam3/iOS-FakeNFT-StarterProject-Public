//
//  CartTableViewCell.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit
import Kingfisher

final class CartTableViewCell: UITableViewCell, ReuseIdentifying {
    
    static var defaultReuseIdentifier: String  = "CartTableViewCell"
    
    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nftNameLabel: UILabel = {
        let label = UILabel()
        label.font = .bold17
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "Default name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingView = RatingView(rating: 0)
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .regular13
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .left
        label.text = L.Cart.price
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nftPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .bold17
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let deletebutton: UIButton = {
        let button = UIButton()
        let image = A.Icons.deleteNft.image
        button.setImage(image, for: .normal)
        button.tintColor = A.Colors.blackDynamic.color
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var viewModel: CartTableViewCellViewModel! {
        didSet {
            nftImageView.kf.indicatorType = .activity
            nftImageView.kf.setImage(with: viewModel.imageURL)
            nftNameLabel.text = viewModel.nftName
            nftPriceLabel.text = viewModel.priceString
            ratingView.updateRating(viewModel.rating)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = A.Colors.whiteDynamic.color
        contentView.addSubview(nftImageView)
        contentView.addSubview(nftNameLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(priceLabel)
        contentView.addSubview(nftPriceLabel)
        deletebutton.addTarget(self, action: #selector(deleteNft), for: .touchUpInside)
        contentView.addSubview(deletebutton)
        layoutSupport()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutSupport() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 140),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            nftImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            nftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            nftNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            nftNameLabel.leftAnchor.constraint(equalTo: nftImageView.rightAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            ratingView.leftAnchor.constraint(equalTo: nftImageView.rightAnchor, constant: 20),
            ratingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50)
        ])
        NSLayoutConstraint.activate([
            priceLabel.leftAnchor.constraint(equalTo: nftImageView.rightAnchor, constant: 20),
            priceLabel.bottomAnchor.constraint(equalTo: nftPriceLabel.topAnchor, constant: -2)
        ])
        NSLayoutConstraint.activate([
            nftPriceLabel.leftAnchor.constraint(equalTo: nftImageView.rightAnchor, constant: 20),
            nftPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            deletebutton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            deletebutton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deletebutton.heightAnchor.constraint(equalToConstant: 40),
            deletebutton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc
    private func deleteNft() {
        guard let image = nftImageView.image else { return }
        viewModel.pressDelete(image:image)
    }
}