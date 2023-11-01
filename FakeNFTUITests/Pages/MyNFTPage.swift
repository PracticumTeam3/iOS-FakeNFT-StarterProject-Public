//
//  MyNFTPage.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 02.11.2023.
//

import XCTest

// MARK: - MyNFTPage
struct MyNFTPage {

    // MARK: - Public properties
    var backButton: XCUIElement {
        navigationBar.buttons[AccessibilityIdentifier.MyNFTPage.backButton]
    }

    var sortButton: XCUIElement {
        navigationBar.buttons[AccessibilityIdentifier.MyNFTPage.sortButton]
    }

    var searchBar: XCUIElement {
        navigationBar.searchFields.firstMatch
    }

    // MARK: - Private properties
    private var view: XCUIElement {
        XCUIApplication().otherElements[AccessibilityIdentifier.MyNFTPage.view]
    }

    private var navigationBar: XCUIElement {
        XCUIApplication().navigationBars.firstMatch
    }

    private var tableView: XCUIElement {
        view.tables[AccessibilityIdentifier.MyNFTPage.tableView]
    }

    private var emptyLabel: XCUIElement {
        view.staticTexts[AccessibilityIdentifier.MyNFTPage.emptyLabel]
    }

    private var nothingFoundLabel: XCUIElement {
        view.staticTexts[AccessibilityIdentifier.MyNFTPage.nothingFoundLabel]
    }

    private var cellsCount: Int {
        tableView.cells.count
    }

    // MARK: - Public methods
    func validate(models: [NFTModel] = [], isSearch: Bool = false) {
        XCTAssertTrue(view.waitForExistence(timeout: 2.0))
        XCTAssertTrue(navigationBar.exists)
        XCTAssertEqual(navigationBar.identifier, "My NFT")
        XCTAssertTrue(searchBar.exists)

        if isSearch {
            validateSearchScreen(models: models)
        } else {
            validateStandartScreen(models: models)
        }
    }

    // MARK: - Private methods
    private func validateTableView(models: [NFTModel]) {
        XCTAssertTrue(tableView.exists)
        XCTAssertEqual(cellsCount, models.count)
        for (i, model) in models.enumerated() {
            XCTAssertEqual(cell(index: i).toMyNFT, model)
        }
    }

    private func validateSearchScreen(models: [NFTModel]) {
        XCTAssertFalse(backButton.exists)
        XCTAssertFalse(sortButton.exists)
        if models.isEmpty {
            XCTAssertTrue(nothingFoundLabel.exists)
            XCTAssertFalse(tableView.exists)
        } else {
            validateTableView(models: models)
        }
    }

    private func validateStandartScreen(models: [NFTModel]) {
        XCTAssertTrue(backButton.exists)
        if models.isEmpty {
            XCTAssertTrue(emptyLabel.exists)
            XCTAssertFalse(tableView.exists)
            XCTAssertFalse(sortButton.exists)
        } else {
            XCTAssertTrue(sortButton.exists)
            validateTableView(models: models)
        }
    }

    private func cell(index: Int) -> MyNFTCell {
        let cell = tableView.cells.element(boundBy: index)
        return MyNFTCell(
            imageView: cell.images[AccessibilityIdentifier.MyNFTPage.Cell.imageView],
            name: cell.staticTexts[AccessibilityIdentifier.MyNFTPage.Cell.name],
            rating: cell.otherElements[AccessibilityIdentifier.RatingView.view],
            authorTitle: cell.staticTexts[AccessibilityIdentifier.MyNFTPage.Cell.authorTitle],
            authorLabel: cell.staticTexts[AccessibilityIdentifier.MyNFTPage.Cell.authorLabel],
            priceTitle: cell.staticTexts[AccessibilityIdentifier.MyNFTPage.Cell.priceTitle],
            priceLabel: cell.staticTexts[AccessibilityIdentifier.MyNFTPage.Cell.priceLabel]
        )
    }

}
