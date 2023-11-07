//
//  ProfileTests.swift
//  FakeNFTTests
//
//  Created by Artem Novikov on 01.11.2023.
//

@testable import FakeNFT
import XCTest

// MARK: - ProfileTests
final class ProfileTests: XCTestCase {

    func testViewControllerCallsFetchProfile() {
        // given
        let profileViewModel = ProfileViewModelSpy()
        let profileViewController = ProfileViewController(viewModel: profileViewModel)

        // when
        _ = profileViewController.view

        // then
        XCTAssertTrue(profileViewModel.isFetchProfileCalled)
    }

    func testViewModelBindsOnProfileInfoChange() {
        // given
        let storageService = ProfileStorageServiceSpy()
        let profileViewModel = ProfileViewModel(profileStorageService: storageService)
        let profileViewController = ProfileViewController(viewModel: profileViewModel)

        // when
        _ = profileViewController.view

        // then
        XCTAssertNotNil(storageService.onProfileInfoChanged)
    }

    func testViewModelChangeProfileModel() {
        // given
        let storageService = ProfileStorageServiceSpy()
        let profileViewModel = ProfileViewModel(profileStorageService: storageService)
        XCTAssertEqual(profileViewModel.model, storageService.profile)

        // when
        storageService.profile = ProfileModel(name: "",
                                              avatar: "",
                                              description: "",
                                              website: "",
                                              nfts: [],
                                              likes: [])

        // then
        XCTAssertEqual(profileViewModel.model, storageService.profile)
    }

    func testViewModelCells() {
        // given
        let storageService = ProfileStorageServiceSpy()
        let profileViewModel = ProfileViewModel(profileStorageService: storageService)

        XCTAssertEqual(
            profileViewModel.cells.map { $0.name },
            [
                ProfileTableViewCells.myNFT(2).name,
                ProfileTableViewCells.favouriteNFT(1).name,
                ProfileTableViewCells.about.name
            ]
        )

        // when
        storageService.profile = ProfileModel(name: "",
                                              avatar: "",
                                              description: "",
                                              website: "",
                                              nfts: [],
                                              likes: ["3", "4", "5"])

        // then
        XCTAssertEqual(
            profileViewModel.cells.map { $0.name },
            [
                ProfileTableViewCells.myNFT(0).name,
                ProfileTableViewCells.favouriteNFT(3).name,
                ProfileTableViewCells.about.name
            ]
        )
    }

    func testViewControllerBinds() {
        // given
        let profileViewModel = ProfileViewModelSpy()
        let profileViewController = ProfileViewController(viewModel: profileViewModel)

        // when
        _ = profileViewController.view

        // then
        XCTAssertNotNil(profileViewModel.onEditError)
        XCTAssertNotNil(profileViewModel.onFetchError)
        XCTAssertNotNil(profileViewModel.onProfileInfoChanged)
    }

}
