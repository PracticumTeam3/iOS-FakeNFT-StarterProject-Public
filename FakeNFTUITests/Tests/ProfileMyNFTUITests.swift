//
//  ProfileMyNFTUITests.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 02.11.2023.
//

import XCTest

// MARK: - ProfileMyNFTUITests
final class ProfileMyNFTUITests: BaseUITest {

    // MARK: - Overridden methods
    override func setUp() {
        super.setUp()
        setDefaultConfig()
    }

    // MARK: - Tests
    func testMyNFT() throws {
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let myNFTPage = MyNFTPage()
        profilePage.myNFT.tap()
        myNFTPage.validate(models: MockData.myNFTModels)
    }

    func testMyNFTBack() throws {
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let myNFTPage = MyNFTPage()
        profilePage.myNFT.tap()
        myNFTPage.validate(models: MockData.myNFTModels)
        myNFTPage.backButton.tap()
        profilePage.validate(model: MockData.profile)
    }

    func testMyNFTSearchByAuthor() throws {
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let myNFTPage = MyNFTPage()
        profilePage.myNFT.tap()
        myNFTPage.searchBar.tap()
        myNFTPage.searchBar.typeText("Edwards")
        myNFTPage.validate(models: [MockData.myNFTModels[0]], isSearch: true)
    }

    func testMyNFTSearchByName() throws {
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let myNFTPage = MyNFTPage()
        profilePage.myNFT.tap()
        myNFTPage.searchBar.tap()
        myNFTPage.searchBar.typeText("BeTH")
        myNFTPage.validate(models: [MockData.myNFTModels[1]], isSearch: true)
    }

    func testMyNFTSearchNothingFound() throws {
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let myNFTPage = MyNFTPage()
        profilePage.myNFT.tap()
        myNFTPage.searchBar.tap()
        myNFTPage.searchBar.typeText("123")
        myNFTPage.validate(models: [], isSearch: true)
    }

    func testMyNFTEmpty() throws {
        mockServer.config = [.profileEmptyNFTs]
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let myNFTPage = MyNFTPage()
        profilePage.myNFT.tap()
        myNFTPage.validate(models: [])
    }

    func testMyNFTSort() throws {
        launchAndOpenProfileTab()
        let profilePage = ProfilePage()
        let myNFTPage = MyNFTPage()
        let alertPage = AlertPage()
        profilePage.myNFT.tap()
        myNFTPage.validate(models: MockData.myNFTModels)

        myNFTPage.sortButton.tap()
        alertPage.button(text: .byName).tap()
        myNFTPage.validate(models: MockData.myNFTModels.sorted(by: { $0.name < $1.name }))

        myNFTPage.sortButton.tap()
        alertPage.button(text: .byPrice).tap()
        myNFTPage.validate(models: MockData.myNFTModels.sorted(by: { $0.price > $1.price }))

        myNFTPage.sortButton.tap()
        alertPage.button(text: .byRating).tap()
        myNFTPage.validate(models: MockData.myNFTModels.sorted(by: { $0.rating > $1.rating }))
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
