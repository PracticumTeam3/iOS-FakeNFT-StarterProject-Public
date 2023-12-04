//
//  ProfileFavouriteNFTUITests.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 02.11.2023.
//

import XCTest

// MARK: - ProfileFavouriteNFTUITests
final class ProfileFavouriteNFTUITests: BaseUITest {

    // MARK: - Overridden methods
    override func setUp() {
        super.setUp()
        setDefaultConfig()
    }

    // MARK: - Tests
    func testFavouriteNFT() throws {
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let favouriteNFTPage = FavouriteNFTPage()
        profilePage.favouriteNFT.tap()
        favouriteNFTPage.validate(models: MockData.favouriteNFTModels)
    }

    func testFavouriteNFTBack() throws {
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let favouriteNFTPage = FavouriteNFTPage()
        profilePage.favouriteNFT.tap()
        favouriteNFTPage.validate(models: MockData.favouriteNFTModels)
        favouriteNFTPage.backButton.tap()
        profilePage.validate(model: MockData.profile)
    }

    func testFavouriteNFTSearchByName() throws {
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let favouriteNFTPage = FavouriteNFTPage()
        profilePage.favouriteNFT.tap()
        favouriteNFTPage.searchBar.tap()
        favouriteNFTPage.searchBar.typeText("BeTH")
        favouriteNFTPage.validate(models: [MockData.favouriteNFTModels[1]], isSearch: true)
    }

    func testFavouriteNFTSearchNothingFound() throws {
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let favouriteNFTPage = FavouriteNFTPage()
        profilePage.favouriteNFT.tap()
        favouriteNFTPage.searchBar.tap()
        favouriteNFTPage.searchBar.typeText("123")
        favouriteNFTPage.validate(models: [], isSearch: true)
    }

    func testFavouriteNFTUnlike() throws {
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let favouriteNFTPage = FavouriteNFTPage()
        profilePage.favouriteNFT.tap()
        mockServer.config = MockServerConfig.profileUnlike
        favouriteNFTPage.cell(index: 0).likeButton.tap()
        favouriteNFTPage.validate(models: Array(MockData.favouriteNFTModels.dropFirst()))
    }

    func testFavouriteNFTEmpty() throws {
        mockServer.config = [.profileEmptyNFTs]
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let favouriteNFTPage = FavouriteNFTPage()
        profilePage.favouriteNFT.tap()
        favouriteNFTPage.validate(models: [])
    }

    // MARK: - Private methods
    private func launchAndOpenProfileTab() {
        app.launch()
        TabBarPage().profile.tap()
    }

    private func setDefaultConfig() {
        mockServer.config = [.profile] + MockServerConfig.nfts + MockServerConfig.authors
    }

}
