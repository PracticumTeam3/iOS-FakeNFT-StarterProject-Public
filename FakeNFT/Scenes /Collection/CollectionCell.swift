//
//  CollectionCell.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 28.10.2023.
//

import Foundation
import UIKit
import Kingfisher

class CollectionCell:UICollectionViewCell {

    let imageCard: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()

    let ratingView: RatingBarView = {
        let label = RatingBarView(rating: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let lableName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = A.Colors.blackDynamic.color
        label.font = .Bold.small
        label.textAlignment = .left
        label.text = "Archie"
        return label
    }()

    let lableCost: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = A.Colors.blackDynamic.color
        label.font = .Medium.small
        label.textAlignment = .left
        label.text = "1 ETH"
        return label
    }()

    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(Self.didTaplikeButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(A.Icons.favouriteInactive.image, for: .normal)
        return button
    }()

    lazy var сartButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(Self.didTapСartButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(A.Icons.basket.image, for: .normal)
        button.tintColor = A.Colors.blackDynamic.color
        return button
    }()

    let viewCell:UIView = {
       let cell = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()

    var viewModel: CollectionViewModel?
    var id: String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = A.Colors.whiteDynamic.color
        contentView.addSubview(viewCell)

        NSLayoutConstraint.activate([
            viewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            viewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            viewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            viewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) не был реализован")
    }

    private func setupViews() {
        viewCell.addSubview(imageCard)
        viewCell.addSubview(ratingView)
        viewCell.addSubview(lableName)
        viewCell.addSubview(lableCost)
        viewCell.addSubview(likeButton)
        viewCell.addSubview(сartButton)

        NSLayoutConstraint.activate([
            imageCard.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: 0),
            imageCard.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 0),
            imageCard.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant: 0),
            imageCard.heightAnchor.constraint(equalToConstant: 108),
            likeButton.topAnchor.constraint(equalTo: imageCard.topAnchor, constant: 0),
            likeButton.trailingAnchor.constraint(equalTo: imageCard.trailingAnchor, constant: 0),
            ratingView.topAnchor.constraint(equalTo: imageCard.bottomAnchor, constant: 8),
            ratingView.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 0),
            lableName.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 5),
            lableName.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 0),
            lableCost.topAnchor.constraint(equalTo: lableName.bottomAnchor, constant: 4),
            lableCost.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 0),
            lableCost.bottomAnchor.constraint(lessThanOrEqualTo: viewCell.bottomAnchor, constant: -20),
            сartButton.topAnchor.constraint(equalTo: lableName.topAnchor, constant: 0),
            сartButton.bottomAnchor.constraint(equalTo: lableCost.bottomAnchor, constant: 0),
            сartButton.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant: 0)
        ])
    }

    @objc
    private func didTaplikeButton () {
        if let id = id {
            viewModel?.setLikes(id: id)
        }
    }

    @objc
    private func didTapСartButton () {
        if let id = id {
            viewModel?.setCart(id: id)
        }
    }

    func setData(collectionCellData: NFTCollectionModel, id: String, isFavorite:Bool, isInCart: Bool) {
        self.id = id
        lableCost.text = "\(collectionCellData.price) ETH"
        lableName.text = collectionCellData.name
        if let image = collectionCellData.image?.addingPercentEncoding(
            withAllowedCharacters: .urlFragmentAllowed) {
            let url = URL(string: image)
            imageCard.kf.setImage(with:url)
        }
        ratingView.setData(rating: collectionCellData.rating)
        if isFavorite {
            likeButton.setImage(A.Icons.favouriteActive.image, for: .normal)
        } else {
            likeButton.setImage(A.Icons.favouriteInactive.image, for: .normal)
        }

        if isInCart {
            сartButton.setImage(A.Icons.deleteNft.image, for: .normal)
        } else {
            сartButton.setImage(A.Icons.basket.image, for: .normal)
        }
    }

} // end CollectionCell
