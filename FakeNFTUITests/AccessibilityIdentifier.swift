//
//  AccessibilityIdentifier.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 01.11.2023.
//

// MARK: - AccessibilityIdentifier
enum AccessibilityIdentifier {

    enum Alert {
        static let view = "AlertView"
    }

    enum TabBar {
        static let view = "TabBarView"
        static let profile = "TabBarProfile"
        static let cart = "TabBarCart"
        static let catalog = "TabBarCatalog"
        static let statistic = "TabBarStatistic"
    }

    enum ProfilePage {
        static let view = "ProfileView"
        static let tableView = "ProfileTableView"
        static let avatarImageView = "ProfileAvatarImageView"
        static let nameLabel = "ProfileNameLabel"
        static let descriptionLabel = "ProfileDescriptionLabel"
        static let websiteLabel = "ProfileWebsiteLabel"
        static let editButton = "ProfileEditButton"
    }

    enum EditProfilePage {
        static let view = "EditProfileView"
        static let avatarImageView = "EditProfileAvatarImageView"
        static let avatarChangeView = "EditProfileAvatarChangeView"
        static let avatarChangeViewHidden = "EditProfileAvatarChangeViewHidden"
        static let avatarChangeLabel = "EditProfileAvatarChangeLabel"
        static let nameLabel = "EditProfileNameLabel"
        static let nameTextField = "EditProfileNameTextField"
        static let descriptionLabel = "EditProfileDescriptionLabel"
        static let descriptionTextView = "EditProfileDescriptionTextView"
        static let websiteLabel = "EditProfileWebsiteLabel"
        static let websiteTextField = "EditProfileWebsiteTextField"
        static let closeButton = "EditProfileCloseButton"
    }

    enum MyNFTPage {
        static let view = "MyNFTView"
        static let emptyLabel = "MyNFTEmptyLabel"
        static let nothingFoundLabel = "MyNFTNothingFoundLabel"
        static let tableView = "MyNFTTableView"
        static let backButton = "MyNFTBackButton"
        static let sortButton = "MyNFTSortButton"

        enum Cell {
            static let imageView = "MyNFTCellImageView"
            static let name = "MyNFTCellName"
            static let authorTitle = "MyNFTCellAuthorTitle"
            static let authorLabel = "MyNFTCellAuthorLabel"
            static let priceTitle = "MyNFTCellPriceTitle"
            static let priceLabel = "MyNFTCellPriceLabel"
        }
    }

    enum FavouriteNFTPage {
        static let view = "FavouriteNFTView"
        static let emptyLabel = "FavouriteNFTEmptyLabel"
        static let nothingFoundLabel = "FavouriteNFTNothingFoundLabel"
        static let collectionView = "FavouriteNFTCollectionView"
        static let backButton = "FavouriteNFTBackButton"

        enum Cell {
            static let imageView = "FavouriteNFTCellImageView"
            static let likeButton = "FavouriteNFTCellLikeButton"
            static let name = "FavouriteNFTCellName"
            static let priceLabel = "FavouriteNFTCellPriceLabel"
        }
    }

    enum WebView {
        static let view = "WebViewView"
        static let backButton = "WebViewBackButton"
        static let closeButton = "WebViewCloseButton"
    }

    enum RatingView {
        static let view = "RatingView"
    }

}
