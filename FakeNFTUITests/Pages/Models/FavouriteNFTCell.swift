//
//  FavouriteNFTCell.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 02.11.2023.
//

import XCTest

// MARK: - FavouriteNFTCell
struct FavouriteNFTCell {

    let imageView: XCUIElement
    let likeButton: XCUIElement
    let name: XCUIElement
    let rating: XCUIElement
    let priceLabel: XCUIElement

    var toFavouriteNFT: FavouriteNFTModel {
        FavouriteNFTModel(
            id: "",
            image: "",
            name: name.label,
            rating: Int(rating.value as? String ?? "0") ?? 0,
            price: Float(priceLabel.label.substring(from: 4)) ?? 0
        )
    }

}
