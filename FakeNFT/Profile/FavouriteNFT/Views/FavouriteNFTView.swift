//
//  FavouriteNFTView.swift
//  FakeNFT
//
//  Created by Artem Novikov on 18.10.2023.
//

import UIKit
import SkeletonView

// MARK: - FavouriteNFTView
final class FavouriteNFTView: UIView {

    // MARK: - Public properties
    enum State {
        case empty
        case standart
        case nothingFound
    }

    var refreshControl: RefreshControl?

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.alwaysBounceVertical = true
        collectionView.isSkeletonable = true
        collectionView.backgroundColor = A.Colors.whiteDynamic.color
        collectionView.allowsSelection = false
        collectionView.register(FavouriteNFTCollectionViewCell.self)
        collectionView.accessibilityIdentifier = AccessibilityIdentifier.FavouriteNFTPage.collectionView
        return collectionView
    }()

    // MARK: - Private properties
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = A.Colors.blackDynamic.color
        label.font = .Bold.small
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func changeState(_ state: State) {
        switch state {
        case .empty:
            emptyLabel.isHidden = false
            collectionView.isHidden = true
            emptyLabel.text = L.Profile.FavouriteNFT.empty
            emptyLabel.accessibilityIdentifier = AccessibilityIdentifier.FavouriteNFTPage.emptyLabel
        case .nothingFound:
            emptyLabel.isHidden = false
            collectionView.isHidden = true
            emptyLabel.text = L.Profile.FavouriteNFT.nothingFound
            emptyLabel.accessibilityIdentifier = AccessibilityIdentifier.FavouriteNFTPage.nothingFoundLabel
        case .standart:
            emptyLabel.isHidden = true
            collectionView.isHidden = false
        }
    }

    // MARK: - Private methods
    private func setupUI() {
        accessibilityIdentifier = AccessibilityIdentifier.FavouriteNFTPage.view
        backgroundColor = A.Colors.whiteDynamic.color
        emptyLabel.isHidden = true
    }

    private func setupLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])

        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emptyLabel)

        NSLayoutConstraint.activate([
            emptyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            emptyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
