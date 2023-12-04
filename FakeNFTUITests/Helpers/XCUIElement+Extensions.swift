//
//  XCUIElement+Extensions.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 01.11.2023.
//

import XCTest

extension XCUIElement {

    private var selectAll: XCUIElement {
        XCUIApplication().menuItems["Select All"]
    }

    func clearText(andReplaceWith newText: String? = nil) {
        tap()
        press(forDuration: 1.0)

        if !selectAll.waitForExistence(timeout: 1.0) {
            press(forDuration: 1.0)
        }

        if selectAll.waitForExistence(timeout: 1.0) {
            selectAll.tap()
            typeText(String(XCUIKeyboardKey.delete.rawValue))
        }

        if let newText {
            typeText(newText)
        }
    }

}
