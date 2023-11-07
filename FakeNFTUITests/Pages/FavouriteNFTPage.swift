//
//  FavouriteNFTPage.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 02.11.2023.
//

import XCTest

// MARK: - FavouriteNFTPage
struct FavouriteNFTPage {

    // MARK: - Public properties
    var backButton: XCUIElement {
        navigationBar.buttons[AccessibilityIdentifier.FavouriteNFTPage.backButton]
    }

    var searchBar: XCUIElement {
        navigationBar.searchFields.firstMatch
    }

    // MARK: - Private properties
    private var view: XCUIElement {
        XCUIApplication().otherElements[AccessibilityIdentifier.FavouriteNFTPage.view]
    }

    private var navigationBar: XCUIElement {
        XCUIApplication().navigationBars.firstMatch
    }

    private var collectionView: XCUIElement {
        view.collectionViews[AccessibilityIdentifier.FavouriteNFTPage.collectionView]
    }

    private var emptyLabel: XCUIElement {
        view.staticTexts[AccessibilityIdentifier.FavouriteNFTPage.emptyLabel]
    }

    private var nothingFoundLabel: XCUIElement {
        view.staticTexts[AccessibilityIdentifier.FavouriteNFTPage.nothingFoundLabel]
    }

    private var cellsCount: Int {
        collectionView.cells.count
    }

    // MARK: - Public methods
    func validate(models: [FavouriteNFTModel] = [], isSearch: Bool = false) {
        XCTAssertTrue(view.waitForExistence(timeout: 2.0))
        XCTAssertTrue(navigationBar.exists)
        XCTAssertEqual(navigationBar.identifier, "Favourite NFT")
        XCTAssertTrue(searchBar.exists)

        if isSearch {
            validateSearchScreen(models: models)
        } else {
            validateStandartScreen(models: models)
        }
    }

    func cell(index: Int) -> FavouriteNFTCell {
        let cell = collectionView.cells.element(boundBy: index)
        return FavouriteNFTCell(
            imageView: cell.images[AccessibilityIdentifier.FavouriteNFTPage.Cell.imageView],
            likeButton: cell.buttons[AccessibilityIdentifier.FavouriteNFTPage.Cell.likeButton],
            name: cell.staticTexts[AccessibilityIdentifier.FavouriteNFTPage.Cell.name],
            rating: cell.otherElements[AccessibilityIdentifier.RatingView.view],
            priceLabel: cell.staticTexts[AccessibilityIdentifier.FavouriteNFTPage.Cell.priceLabel]
        )
    }

    // MARK: - Private methods
    private func validateCollectionView(models: [FavouriteNFTModel]) {
        XCTAssertTrue(collectionView.exists)
        XCTAssertEqual(cellsCount, models.count)
        for (i, model) in models.enumerated() {
            XCTAssertEqual(cell(index: i).toFavouriteNFT, model)
        }
    }

    private func validateSearchScreen(models: [FavouriteNFTModel]) {
        XCTAssertFalse(backButton.exists)
        if models.isEmpty {
            XCTAssertTrue(nothingFoundLabel.exists)
            XCTAssertFalse(collectionView.exists)
        } else {
            validateCollectionView(models: models)
        }
    }

    private func validateStandartScreen(models: [FavouriteNFTModel]) {
        XCTAssertTrue(backButton.exists)
        if models.isEmpty {
            XCTAssertTrue(emptyLabel.exists)
            XCTAssertFalse(collectionView.exists)
        } else {
            validateCollectionView(models: models)
        }
    }

}
