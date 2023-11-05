//
//  MyNFTCell.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 02.11.2023.
//

import XCTest

// MARK: - MyNFTCell
struct MyNFTCell {

    let imageView: XCUIElement
    let name: XCUIElement
    let rating: XCUIElement
    let authorTitle: XCUIElement
    let authorLabel: XCUIElement
    let priceTitle: XCUIElement
    let priceLabel: XCUIElement

    var toMyNFT: NFTModel {
        NFTModel(
            image: "",
            name: name.label,
            authorName: authorLabel.label,
            rating: Int(rating.value as? String ?? "0") ?? 0,
            price: Float(priceLabel.label.substring(from: 4)) ?? 0
        )
    }

}
