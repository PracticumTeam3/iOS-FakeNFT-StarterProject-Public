//
//  MyNFTTableViewCell.swift
//  FakeNFT
//
//  Created by Artem Novikov on 11.10.2023.
//

import UIKit
import Kingfisher
import SkeletonView

// MARK: - MyNFTTableViewCell
final class MyNFTTableViewCell: UITableViewCell, ReuseIdentifying {

    // MARK: - Private properties
    private enum Constants {
        static let skeletonText = "             "
        enum ImageView {
            static let cornerRadius: CGFloat = 12
            static let widthAndHeight: CGFloat = 108
            static let maxRetryCount: Int = 2
            static let retryInterval: DelayRetryStrategy.Interval = .seconds(3)
        }
        enum InfoStackView {
            static let spacing: CGFloat = 4
            static let leadingInset: CGFloat = 20
            static let height: CGFloat = 62
        }
        enum AuthorStackView {
            static let spacing: CGFloat = 4
        }
        enum PriceStackView {
            static let spacing: CGFloat = 2
            static let width: CGFloat = 100
        }
        enum ViewWithContent {
            static let inset: CGFloat = 16
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
        imageView.accessibilityIdentifier = AccessibilityIdentifier.MyNFTPage.Cell.imageView
        return imageView
    }()

    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.InfoStackView.spacing
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        for subview in [nftNameLabel, ratingStackView, authorStackView] {
            stackView.addArrangedSubview(subview)
        }
        return stackView
    }()

    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.PriceStackView.spacing
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        for subview in [priceTitleLabel, priceLabel] {
            stackView.addArrangedSubview(subview)
        }
        return stackView
    }()

    private let ratingStackView = RatingStackView()

    private lazy var authorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = Constants.AuthorStackView.spacing
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        for subview in [authorTitleLabel, authorLabel] {
            stackView.addArrangedSubview(subview)
        }
        return stackView
    }()

    private let nftNameLabel: UILabel = {
        let label = UILabel()
        label.font = .Bold.small
        label.textColor = A.Colors.blackDynamic.color
        label.text = Constants.skeletonText
        label.accessibilityIdentifier = AccessibilityIdentifier.MyNFTPage.Cell.name
        return label
    }()

    private let authorTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Regular.medium
        label.textColor = A.Colors.blackDynamic.color
        label.text = L.Profile.MyNFT.Author.title
        label.accessibilityIdentifier = AccessibilityIdentifier.MyNFTPage.Cell.authorTitle
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .Regular.small
        label.textColor = A.Colors.blackDynamic.color
        label.text = Constants.skeletonText
        label.accessibilityIdentifier = AccessibilityIdentifier.MyNFTPage.Cell.authorLabel
        return label
    }()

    private let priceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Regular.small
        label.textColor = A.Colors.blackDynamic.color
        label.text = L.Profile.MyNFT.Price.title
        label.accessibilityIdentifier = AccessibilityIdentifier.MyNFTPage.Cell.priceTitle
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Bold.small
        label.textColor = A.Colors.blackDynamic.color
        label.text = Constants.skeletonText
        label.accessibilityIdentifier = AccessibilityIdentifier.MyNFTPage.Cell.priceLabel
        return label
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    }

    // MARK: - Public methods
    func configCell(model: NFTModel) {
        setImage(url: model.image)
        authorLabel.text = model.authorName
        nftNameLabel.text = model.name
        priceLabel.text = Self.currencyFormatter.string(from: NSNumber(value: model.price))
        ratingStackView.setRating(rating: model.rating)
    }

    // MARK: - Private methods
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
            guard let self else { return }
            switch result {
            case .success: break
            case .failure: self.nftImageView.image = A.Images.Profile.stub.image
            }
        }
    }

    private func setupUI() {
        backgroundColor = A.Colors.whiteDynamic.color
        contentView.addSubview(viewWithContent)

        [nftImageView, infoStackView, priceStackView].forEach {
            viewWithContent.addSubview($0)
        }
        [
            viewWithContent, nftImageView, infoStackView, priceStackView, ratingStackView,
            nftNameLabel, authorStackView, authorTitleLabel, authorLabel, priceTitleLabel, priceLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.isSkeletonable = true
        }
        self.isSkeletonable = true
        contentView.isSkeletonable = true
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            viewWithContent.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.ViewWithContent.inset
            ),
            viewWithContent.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.ViewWithContent.inset
            ),
            contentView.trailingAnchor.constraint(
                equalTo: viewWithContent.trailingAnchor,
                constant: Constants.ViewWithContent.inset
            ),
            contentView.bottomAnchor.constraint(
                equalTo: viewWithContent.bottomAnchor,
                constant: Constants.ViewWithContent.inset
            )
        ])

        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: viewWithContent.leadingAnchor),
            nftImageView.topAnchor.constraint(equalTo: viewWithContent.topAnchor),
            nftImageView.bottomAnchor.constraint(equalTo: viewWithContent.bottomAnchor),
            nftImageView.widthAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight),
            nftImageView.heightAnchor.constraint(equalToConstant: Constants.ImageView.widthAndHeight)
        ])

        NSLayoutConstraint.activate([
            infoStackView.leadingAnchor.constraint(
                equalTo: nftImageView.trailingAnchor,
                constant: Constants.InfoStackView.leadingInset
            ),
            infoStackView.centerYAnchor.constraint(equalTo: viewWithContent.centerYAnchor),
            infoStackView.heightAnchor.constraint(equalToConstant: Constants.InfoStackView.height)
        ])

        NSLayoutConstraint.activate([
            priceStackView.leadingAnchor.constraint(equalTo: infoStackView.trailingAnchor),
            priceStackView.trailingAnchor.constraint(equalTo: viewWithContent.trailingAnchor),
            priceStackView.centerYAnchor.constraint(equalTo: viewWithContent.centerYAnchor),
            priceStackView.widthAnchor.constraint(equalToConstant: Constants.PriceStackView.width)
        ])
    }

}
