//
//  BaseUITest.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 02.11.2023.
//

import XCTest

// MARK: - BaseUITest
class BaseUITest: XCTestCase {

    // MARK: - Public properties
    let app = XCUIApplication()
    let launchArguments = [
        "UI-Testing",
        "-AppleLanguages", "(en)",
        "-AppleLocale", "en_UK"
    ]
    let mockServer = MockServer()

    // MARK: - Overridden methods
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        mockServer.launch()
        app.launchArguments += launchArguments
    }

    override func tearDown() {
        super.tearDown()
        mockServer.stop()
    }

}
