//
//  FavouriteNFTTests.swift
//  FakeNFTTests
//
//  Created by Artem Novikov on 01.11.2023.
//

@testable import FakeNFT
import XCTest

// MARK: - FavouriteNFTTests
final class FavouriteNFTTests: XCTestCase {

    func testViewControllerCallsFetchFavouriteNFT() {
        // given
        let favouriteNFTViewModel = FavouriteNFTViewModelSpy()
        let favouriteNFTViewController = FavouriteNFTViewController(viewModel: favouriteNFTViewModel)

        // when
        _ = favouriteNFTViewController.view

        // then
        XCTAssertTrue(favouriteNFTViewModel.isFetchFavouriteNFTsCalled)
    }

    func testViewControllerBinds() {
        // given
        let favouriteNFTViewModel = FavouriteNFTViewModelSpy()
        let favouriteNFTViewController = FavouriteNFTViewController(viewModel: favouriteNFTViewModel)

        // when
        _ = favouriteNFTViewController.view

        // then
        XCTAssertNotNil(favouriteNFTViewModel.onNFTListLoaded)
        XCTAssertNotNil(favouriteNFTViewModel.onNFTListLoadError)
    }

}
