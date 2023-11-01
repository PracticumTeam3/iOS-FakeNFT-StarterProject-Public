//
//  EditProfilePage.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 01.11.2023.
//

import XCTest

// MARK: - EditProfilePage
struct EditProfilePage {

    // MARK: - Public properties
    var view: XCUIElement {
        XCUIApplication().otherElements[AccessibilityIdentifier.EditProfilePage.view]
    }

    var closeButton: XCUIElement {
        view.buttons[AccessibilityIdentifier.EditProfilePage.closeButton]
    }

    var avatarChangeView: XCUIElement {
        view.otherElements[AccessibilityIdentifier.EditProfilePage.avatarChangeView]
    }

    var nameTextField: XCUIElement {
        view.textFields[AccessibilityIdentifier.EditProfilePage.nameTextField]
    }

    var descriptionTextView: XCUIElement {
        view.textViews[AccessibilityIdentifier.EditProfilePage.descriptionTextView]
    }

    var websiteTextField: XCUIElement {
        view.textFields[AccessibilityIdentifier.EditProfilePage.websiteTextField]
    }

    // MARK: - Private properties
    private var avatarImageView: XCUIElement {
        view.images[AccessibilityIdentifier.EditProfilePage.avatarImageView]
    }

    private var avatarChangeViewHidden: XCUIElement {
        view.otherElements[AccessibilityIdentifier.EditProfilePage.avatarChangeViewHidden]
    }

    private var avatarChangeLabel: XCUIElement {
        view.staticTexts[AccessibilityIdentifier.EditProfilePage.avatarChangeLabel]
    }

    private var nameLabel: XCUIElement {
        view.staticTexts[AccessibilityIdentifier.EditProfilePage.nameLabel]
    }

    private var descriptionLabel: XCUIElement {
        view.staticTexts[AccessibilityIdentifier.EditProfilePage.descriptionLabel]
    }

    private var websiteLabel: XCUIElement {
        view.staticTexts[AccessibilityIdentifier.EditProfilePage.websiteLabel]
    }

    // MARK: - Public methods
    func validate(model: ProfileModel, isEdited: Bool = false) {
        XCTAssertTrue(view.waitForExistence(timeout: 2.0))

        if isEdited {
            XCTAssertTrue(avatarChangeViewHidden.exists)
        } else {
            XCTAssertTrue(avatarChangeView.exists)
            XCTAssertEqual(avatarChangeLabel.label, "Change photo")
        }
        XCTAssertTrue(avatarImageView.exists)
        XCTAssertTrue(closeButton.exists)

        XCTAssertEqual(nameLabel.label, "Name")
        XCTAssertEqual(descriptionLabel.label, "Description")
        XCTAssertEqual(websiteLabel.label, "Website")

        XCTAssertEqual(nameTextField.value as? String, model.name)
        XCTAssertEqual(descriptionTextView.value as? String, model.description)
        XCTAssertEqual(websiteTextField.value as? String, model.website)
    }

}
