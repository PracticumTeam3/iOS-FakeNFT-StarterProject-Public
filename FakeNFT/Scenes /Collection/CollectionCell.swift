//
//  CollectionCell.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 28.10.2023.
//

import Foundation
import UIKit
class CollectionCell:UICollectionViewCell {

    let imageCard: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()

    let ratingView: RatingBarView = {
        let label = RatingBarView(rating: 3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let lableName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "black")
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        label.text = "Archie"
        return label
    }()

    let lableCost: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "black")
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .left
        label.text = "1 ETH"
        return label
    }()

    let likeButton: UIButton = {
        let button = UIButton()
        button.addTarget(CollectionCell.self, action: #selector(Self.didTaplikeButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favouriteInactive"), for: .normal)
        return button
    }()

    let сartButton: UIButton = {
        let button = UIButton()
        button.addTarget(CollectionCell.self, action: #selector(Self.didTapСartButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cart"), for: .normal)
        return button
    }()

    let viewCell:UIView = {
       let cell = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
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

    }

    @objc
    private func didTapСartButton () {

    }

} // end CollectionCell
