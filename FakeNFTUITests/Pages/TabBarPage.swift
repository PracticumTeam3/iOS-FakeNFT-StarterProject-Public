//
//  TabBarPage.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 02.11.2023.
//

import XCTest

// MARK: - TabBarPage
struct TabBarPage {

    // MARK: - Public properties
    var profile: XCUIElement {
        view.buttons[AccessibilityIdentifier.TabBar.profile]
    }

    var cart: XCUIElement {
        view.buttons[AccessibilityIdentifier.TabBar.cart]
    }

    var catalog: XCUIElement {
        view.buttons[AccessibilityIdentifier.TabBar.catalog]
    }

    var statistic: XCUIElement {
        view.buttons[AccessibilityIdentifier.TabBar.statistic]
    }

    // MARK: - Private properties
    private var view: XCUIElement {
        XCUIApplication().tabBars[AccessibilityIdentifier.TabBar.view]
    }

}
