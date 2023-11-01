//
//  WebViewTests.swift
//  FakeNFTTests
//
//  Created by Artem Novikov on 01.11.2023.
//

@testable import FakeNFT
import XCTest

// MARK: - WebViewTests
final class WebViewTests: XCTestCase {

    func testViewControllerCallsUpdateProgressValue() {
        // given
        let webViewModel = WebViewModelSpy()
        let webViewController = WebViewController(
            webViewModel: webViewModel,
            url: URL(string: "https://ya.ru")!,
            presentation: .modal
        )

        // when
        _ = webViewController.view

        // then
        XCTAssertTrue(webViewModel.isUpdateProgressValueCalled)
    }

    func testViewControllerBinds() {
        // given
        let webViewModel = WebViewModelSpy()
        let webViewController = WebViewController(
            webViewModel: webViewModel,
            url: URL(string: "https://ya.ru")!,
            presentation: .modal
        )

        // when
        _ = webViewController.view

        // then
        XCTAssertNotNil(webViewModel.onProgressChange)
        XCTAssertNotNil(webViewModel.onProgressHide)
    }

}
