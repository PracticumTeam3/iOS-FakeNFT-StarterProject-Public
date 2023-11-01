//
//  ProfilePage.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 01.11.2023.
//

import XCTest

// MARK: - ProfilePage
struct ProfilePage {

    // MARK: - Public properties
    var editButton: XCUIElement {
        XCUIApplication().navigationBars.firstMatch.buttons[AccessibilityIdentifier.ProfilePage.editButton]
    }

    var websiteLabel: XCUIElement {
        view.buttons[AccessibilityIdentifier.ProfilePage.websiteLabel]
    }

    var myNFT: XCUIElement {
        cell(index: 0)
    }

    var favouriteNFT: XCUIElement {
        cell(index: 1)
    }

    var about: XCUIElement {
        cell(index: 2)
    }

    // MARK: - Private properties
    private var view: XCUIElement {
        XCUIApplication().otherElements[AccessibilityIdentifier.ProfilePage.view]
    }

    private var tableView: XCUIElement {
        view.tables[AccessibilityIdentifier.ProfilePage.tableView]
    }

    private var avatarImageView: XCUIElement {
        view.images[AccessibilityIdentifier.ProfilePage.avatarImageView]
    }

    private var nameLabel: XCUIElement {
        view.staticTexts[AccessibilityIdentifier.ProfilePage.nameLabel]
    }

    private var descriptionLabel: XCUIElement {
        view.textViews[AccessibilityIdentifier.ProfilePage.descriptionLabel]
    }

    // MARK: - Public methods
    func validate(model: ProfileModel) {
        XCTAssertTrue(view.waitForExistence(timeout: 2.0))
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(editButton.exists)

        XCTAssertTrue(avatarImageView.exists)
        XCTAssertTrue(nameLabel.exists)
        XCTAssertTrue(descriptionLabel.exists)
        XCTAssertTrue(websiteLabel.exists)

        XCTAssertEqual(nameLabel.label, model.name)
        XCTAssertEqual(descriptionLabel.value as? String, model.description)
        XCTAssertEqual(websiteLabel.label, model.website)

        XCTAssertEqual(cellLabel(index: 0), "My NFT (\(model.nfts.count))")
        XCTAssertEqual(cellLabel(index: 1), "Favourite NFT (\(model.likes.count))")
        XCTAssertEqual(cellLabel(index: 2), "About the developer")
    }

    // MARK: - Private methods
    private func cellLabel(index: Int) -> String {
        cell(index: index).staticTexts.firstMatch.label
    }

    private func cell(index: Int) -> XCUIElement {
        tableView.cells.element(boundBy: index)
    }

}
