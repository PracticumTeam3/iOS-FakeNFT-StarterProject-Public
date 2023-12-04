//
//  FavouriteNFTCollectionViewCell.swift
//  FakeNFT
//
//  Created by Artem Novikov on 18.10.2023.
//

import UIKit
import Kingfisher
import SkeletonView

// MARK: - FavouriteNFTCollectionViewCell
protocol FavouriteNFTCollectionViewCellDelegate: AnyObject {
    func didTapOnLikeButton(_ cell: FavouriteNFTCollectionViewCell)
}

// MARK: - FavouriteNFTCollectionViewCell
final class FavouriteNFTCollectionViewCell: UICollectionViewCell, ReuseIdentifying {

    // MARK: - Public properties
    weak var delegate: FavouriteNFTCollectionViewCellDelegate?
    private(set) var id: String?

    // MARK: - Private properties
    private enum Constants {
        static let skeletonText = "             "
        enum ImageView {
            static let cornerRadius: CGFloat = 12
            static let widthAndHeight: CGFloat = 80
            static let maxRetryCount: Int = 2
            static let retryInterval: DelayRetryStrategy.Interval = .seconds(3)
        }
        enum LikeButton {
            static let widthAndHeight: CGFloat = 42
            static let inset: CGFloat = 7
        }
        enum InfoStackView {
            static let spacing: CGFloat = 8
            static let leadingInset: CGFloat = 12
            static let height: CGFloat = 66
        }
    }

    private static var currencyFormatter = CurrencyFormatter()

    private let viewWithContent: UIView = {
        let view = UIView()
        view.backgroundColor = A.Colors.whiteDynamic.color
        return view
    }()

    private let nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.ImageView.cornerRadius
        imageView.layer.masksToBounds = true
        imageView.accessibilityIdentifier = AccessibilityIdentifier.FavouriteNFTPage.Cell.imageView
        return imageView
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(A.Icons.favouriteActive.image, for: .normal)
        button.addTarget(
            self,
            action: #selector(likeButtonClicked),
            for: .touchUpInside
        )
        button.accessibilityIdentifier = AccessibilityIdentifier.FavouriteNFTPage.Cell.likeButton
        return button
    }()

    private let nftNameLabel: UILabel = {
        let label = UILabel()
        label.font = .Bold.small
        label.textColor = A.Colors.blackDynamic.color
        label.text = Constants.skeletonText
        label.accessibilityIdentifier = AccessibilityIdentifier.FavouriteNFTPage.Cell.name
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Regular.medium
        label.textColor = A.Colors.blackDynamic.color
        label.text = Constants.skeletonText
        label.accessibilityIdentifier = AccessibilityIdentifier.FavouriteNFTPage.Cell.priceLabel
        return label
    }()

    private let ratingStackView = RatingStackView()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.InfoStackView.spacing
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        for subview in [nftNameLabel, ratingStackView, priceLabel] {
            stackView.addArrangedSubview(subview)
        }
        return stackView
    }()

    private var pulseAnimation: CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")

        animation.values = [1.0, 1.2, 1.0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 0.7
        return animation
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods
    override func prepareForReuse() {
        super.prepareForReuse()
        nftImageView.kf.cancelDownloadTask()
        changeLikeButtonState(isEnabled: true)
    }

    // MARK: - Public methods
    func configCell(model: FavouriteNFTModel) {
        id = model.id
        setImage(url: model.image)
        nftNameLabel.text = model.name
        priceLabel.text = Self.currencyFormatter.string(from: NSNumber(value: model.price))
        ratingStackView.setRating(rating: model.rating)
    }

    func changeLikeButtonState(isEnabled: Bool) {
        likeButton.isEnabled = isEnabled
    }

    // MARK: - Private methods
    @objc private func likeButtonClicked() {
        delegate?.didTapOnLikeButton(self)
        likeButton.layer.add(pulseAnimation, forKey: "pulse")
    }

    private func setImage(url: String) {
        guard let url = URL(string: url) else { return }

        let placeholder: UIImage = A.Images.Profile.stub.image
        let retry = DelayRetryStrategy(
            maxRetryCount: Constants.ImageView.maxRetryCount,
            retryInterval: Constants.ImageView.retryInterval
        )
        nftImageView.kf.indicatorType = .activity

        nftImageView.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [.retryStrategy(retry)]
        ) { [weak self] result in
            switch result {
            case .success: break
            case .failure: self?.nftImageView.image = A.Images.Profile.stub.image
            }
        }
    }

    private func setupUI() {
        backgroundColor = A.Colors.whiteDynamic.color
        contentView.addSubview(viewWithContent)

        [nftImageView, infoStackView, likeButton].forEach {
            viewWithContent.addSubview($0)
        }
        [
            viewWithContent, nftImageView, likeButton, infoStackView,
            ratingStackView, nftNameLabel, priceLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.isSkeletonable = true
        }
        likeButton.isHiddenWhenSkeletonIsActive = true
        isSkeletonable = true
        contentView.isSkeletonable = true
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            viewWithContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewWithContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: viewWithContent.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: viewWithContent.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: viewWithContent.leadingAnchor),
            nftImageView.topAnchor.constraint(equalTo: viewWithContent.topAnchor),
            nftImageView.bottomAnchor.constraint(equalTo: viewWithContent.bottomAnchor),
            nftImageView.widthAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight),
            nftImageView.heightAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight)
        ])

        NSLayoutConstraint.activate([
            nftImageView.topAnchor.constraint(
                equalTo: likeButton.topAnchor,
                constant: Constants.LikeButton.inset
            ),
            likeButton.trailingAnchor.constraint(
                equalTo: nftImageView.trailingAnchor,
                constant: Constants.LikeButton.inset
            ),
            likeButton.widthAnchor.constraint(equalToConstant: Constants.LikeButton.widthAndHeight),
            likeButton.heightAnchor.constraint(equalToConstant: Constants.LikeButton.widthAndHeight)
        ])

        NSLayoutConstraint.activate([
            infoStackView.leadingAnchor.constraint(
                equalTo: nftImageView.trailingAnchor,
                constant: Constants.InfoStackView.leadingInset
            ),
            infoStackView.trailingAnchor.constraint(equalTo: viewWithContent.trailingAnchor),
            infoStackView.centerYAnchor.constraint(equalTo: viewWithContent.centerYAnchor),
            infoStackView.heightAnchor.constraint(equalToConstant: Constants.InfoStackView.height)
        ])
    }

}
