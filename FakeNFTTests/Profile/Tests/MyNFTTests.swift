//
//  MyNFTTests.swift
//  FakeNFTTests
//
//  Created by Artem Novikov on 01.11.2023.
//

@testable import FakeNFT
import XCTest

// MARK: - MyNFTTests
final class MyNFTTests: XCTestCase {

    func testViewControllerCallsFetchNFT() {
        // given
        let myNFTViewModel = MyNFTViewModelSpy()
        let myNFTViewController = MyNFTViewController(viewModel: myNFTViewModel)

        // when
        _ = myNFTViewController.view

        // then
        XCTAssertTrue(myNFTViewModel.isFetchNFTsCalled)
    }

    func testViewControllerBinds() {
        // given
        let myNFTViewModel = MyNFTViewModelSpy()
        let myNFTViewController = MyNFTViewController(viewModel: myNFTViewModel)

        // when
        _ = myNFTViewController.view

        // then
        XCTAssertNotNil(myNFTViewModel.onNFTListLoaded)
        XCTAssertNotNil(myNFTViewModel.onNFTListLoadError)
    }

    func testStorageSortType() {
        // given
        let storageService = ProfileStorageServiceSpy()
        let myNFTViewModel = MyNFTViewModel(profileStorageService: storageService)
        XCTAssertEqual(myNFTViewModel.sortType, .byName)

        // when
        storageService.sortType = .byPrice

        // then
        XCTAssertEqual(myNFTViewModel.sortType, .byPrice)
    }

    func testViewModelSortType() {
        // given
        let storageService = ProfileStorageServiceSpy()
        let myNFTViewModel = MyNFTViewModel(profileStorageService: storageService)
        XCTAssertEqual(myNFTViewModel.sortType, .byName)

        // when
        myNFTViewModel.sortType = .byPrice

        // then
        XCTAssertEqual(storageService.sortType, .byPrice)
    }

}
