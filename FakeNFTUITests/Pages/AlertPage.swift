//
//  AlertPage.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 01.11.2023.
//

import XCTest

// MARK: - AlertPage
struct AlertPage {

    // MARK: - Public properties
    enum ButtonText: String {
        case yes = "Yes"
        case no = "No"
        case ok = "OK"
        case byPrice = "By price"
        case byRating = "By rating"
        case byName = "By name"
    }

    var view: XCUIElement {
        let alert = XCUIApplication().alerts[AccessibilityIdentifier.Alert.view]
        if alert.exists {
            return alert
        }
        return XCUIApplication().otherElements[AccessibilityIdentifier.Alert.view]
    }

    var title: String {
        view.label
    }

    var textField: XCUIElement {
        view.textFields.firstMatch
    }

    // MARK: - Public methods
    func button(text: ButtonText) -> XCUIElement {
        view.buttons[text.rawValue].firstMatch
    }

}
