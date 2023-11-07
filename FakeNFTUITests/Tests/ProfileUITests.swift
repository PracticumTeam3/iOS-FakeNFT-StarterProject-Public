//
//  ProfileUITests.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 01.11.2023.
//

import XCTest

// MARK: - ProfileUITests
final class ProfileUITests: BaseUITest {

    // MARK: - Overridden methods
    override func setUp() {
        super.setUp()
        mockServer.config = [.profile, .editProfile]
        app.launch()
        openProfileTab()
    }

    // MARK: - Tests
    func testValidateProfilePage() throws {
        let profilePage = ProfilePage()
        profilePage.validate(model: MockData.profile)
    }

    func testProfileTapLink() throws {
        let profilePage = ProfilePage()
        let webViewPage = WebViewPage()
        profilePage.websiteLabel.tap()
        webViewPage.validate(state: .modal)
        webViewPage.closeButton.tap()
        profilePage.validate(model: MockData.profile)
    }

    func testProfileOpenAboutDeveloper() throws {
        let profilePage = ProfilePage()
        let webViewPage = WebViewPage()
        profilePage.about.tap()
        webViewPage.validate(state: .navigation)
        webViewPage.backButton.tap()
        profilePage.validate(model: MockData.profile)
    }

    func testValidateEditProfilePage() throws {
        let profilePage = ProfilePage()
        let editProfilePage = EditProfilePage()
        profilePage.editButton.tap()
        editProfilePage.validate(model: MockData.profile)
    }

    func testCloseEditProfilePageWithoutEditing() throws {
        let profilePage = ProfilePage()
        let editProfilePage = EditProfilePage()
        profilePage.editButton.tap()
        _ = editProfilePage.closeButton.waitForExistence(timeout: 2.0)
        editProfilePage.closeButton.tap()
        profilePage.validate(model: MockData.profile)
    }

    func testCloseEditProfilePageAfterEditing() throws {
        let profilePage = ProfilePage()
        let editProfilePage = EditProfilePage()
        let alertPage = AlertPage()

        profilePage.editButton.tap()
        _ = editProfilePage.nameTextField.waitForExistence(timeout: 2.0)
        editProfilePage.nameTextField.clearText(andReplaceWith: MockData.editedProfile.name)
        editProfilePage.view.swipeDown()

        XCTAssertTrue(alertPage.view.exists)

        alertPage.button(text: .no).tap()

        profilePage.validate(model: MockData.profile)
    }

    func testEditProfile() throws {
        let profilePage = ProfilePage()
        let editProfilePage = EditProfilePage()
        let alertPage = AlertPage()

        profilePage.editButton.tap()

        _ = editProfilePage.avatarChangeView.waitForExistence(timeout: 2.0)
        editProfilePage.avatarChangeView.tap()
        alertPage.textField.tap()
        alertPage.textField.typeText(MockData.editedProfile.avatar)
        alertPage.button(text: .ok).tap()

        editProfilePage.nameTextField.clearText(andReplaceWith: MockData.editedProfile.name)
        editProfilePage.descriptionTextView.clearText(andReplaceWith: MockData.editedProfile.description)
        editProfilePage.websiteTextField.clearText(andReplaceWith: MockData.editedProfile.website)

        editProfilePage.validate(model: MockData.editedProfile, isEdited: true)

        editProfilePage.closeButton.tap()
        alertPage.button(text: .yes).tap()

        profilePage.validate(model: MockData.editedProfile)
    }

    // MARK: - Private methods
    private func openProfileTab() {
        TabBarPage().profile.tap()
    }

}
