//
//  WebViewModelSpy.swift
//  FakeNFTTests
//
//  Created by Artem Novikov on 01.11.2023.
//

@testable import FakeNFT

// MARK: - WebViewModelSpy
final class WebViewModelSpy: WebViewModelProtocol {

    var isUpdateProgressValueCalled = false

    var onProgressChange: ((Float) -> Void)?
    var onProgressHide: ((Bool) -> Void)?

    func didUpdateProgressValue(_ newValue: Double) {
        isUpdateProgressValueCalled = true
    }

}
