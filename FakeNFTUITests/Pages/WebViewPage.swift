//
//  WebViewPage.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 02.11.2023.
//

import XCTest

// MARK: - WebViewPage
struct WebViewPage {

    // MARK: - Public properties
    enum State {
        case modal
        case navigation
    }

    var backButton: XCUIElement {
        navigationBar.buttons[AccessibilityIdentifier.WebView.backButton]
    }

    var closeButton: XCUIElement {
        view.buttons[AccessibilityIdentifier.WebView.closeButton]
    }

    // MARK: - Private properties
    private var view: XCUIElement {
        XCUIApplication().otherElements[AccessibilityIdentifier.WebView.view]
    }

    private var navigationBar: XCUIElement {
        XCUIApplication().navigationBars.firstMatch
    }

    // MARK: - Public methods
    func validate(state: State) {
        XCTAssertTrue(view.waitForExistence(timeout: 5.0))

        switch state {
        case .modal:
            XCTAssertTrue(closeButton.exists)
        case .navigation:
            XCTAssertTrue(backButton.exists)
        }
    }

}
