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
    
    private enum Constants {
        static let height: CGFloat = 140
        enum NftImageView {
            static let width: CGFloat = 108
            static let height: CGFloat = 108
            static let leftInset: CGFloat = 16
        }
        enum NftNameLabel {
            static let topInset: CGFloat = 24
            static let leftInset: CGFloat = 20
        }
        enum RatingView {
            static let topInset: CGFloat = 50
            static let leftInset: CGFloat = 20
        }
        enum PriceLabel {
            static let leftInset: CGFloat = 20
            static let bottomInset: CGFloat = 2
        }
        enum NftPriceLabel {
            static let leftInset: CGFloat = 20
            static let bottomInset: CGFloat = 24
        }
        enum DeleteButton {
            static let rightInset: CGFloat = 16
            static let width: CGFloat = 40
            static let height: CGFloat = 40
        }
    }
    
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
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            contentView.heightAnchor.constraint(equalToConstant: Constants.height),
            nftImageView.widthAnchor.constraint(equalToConstant: Constants.NftImageView.width),
            nftImageView.heightAnchor.constraint(equalToConstant: Constants.NftImageView.height),
            nftImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor,
                                               constant: Constants.NftImageView.leftInset),
            nftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            nftNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                              constant: Constants.NftNameLabel.topInset),
            nftNameLabel.leftAnchor.constraint(equalTo: nftImageView.rightAnchor,
                                               constant: Constants.NftNameLabel.leftInset)
        ])
        NSLayoutConstraint.activate([
            ratingView.leftAnchor.constraint(equalTo: nftImageView.rightAnchor,
                                             constant: Constants.RatingView.leftInset),
            ratingView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Constants.RatingView.topInset)
        ])
        NSLayoutConstraint.activate([
            priceLabel.leftAnchor.constraint(equalTo: nftImageView.rightAnchor,
                                             constant: Constants.PriceLabel.leftInset),
            priceLabel.bottomAnchor.constraint(equalTo: nftPriceLabel.topAnchor,
                                               constant: -Constants.PriceLabel.bottomInset)
        ])
        NSLayoutConstraint.activate([
            nftPriceLabel.leftAnchor.constraint(equalTo: nftImageView.rightAnchor,
                                                constant: Constants.NftPriceLabel.leftInset),
            nftPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -Constants.NftPriceLabel.bottomInset)
        ])
        NSLayoutConstraint.activate([
            deletebutton.rightAnchor.constraint(equalTo: contentView.rightAnchor,
                                                constant: -Constants.DeleteButton.rightInset),
            deletebutton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deletebutton.heightAnchor.constraint(equalToConstant: Constants.DeleteButton.height),
            deletebutton.widthAnchor.constraint(equalToConstant: Constants.DeleteButton.width)
        ])
    }
    
    @objc
    private func deleteNft() {
        guard let image = nftImageView.image else { return }
        viewModel.pressDelete(image:image)
    }
}
