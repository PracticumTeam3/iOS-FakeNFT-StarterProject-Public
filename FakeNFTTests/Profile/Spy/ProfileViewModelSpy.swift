//
//  ProfileViewModelSpy.swift
//  FakeNFTTests
//
//  Created by Artem Novikov on 01.11.2023.
//

@testable import FakeNFT

// MARK: - ProfileViewModelSpy
final class ProfileViewModelSpy: ProfileViewModelProtocol {

    var isFetchProfileCalled = false

    var onProfileInfoChanged: (() -> Void)?
    var onFetchError: ((String) -> Void)?
    var onEditError: ((String) -> Void)?

    var model: ProfileModel?
    var cells: [ProfileTableViewCells] = []

    func fetchProfile(completion: @escaping (Result<Void, Error>) -> Void) {
        isFetchProfileCalled = true
    }

    func editProfile(editProfileModel: EditProfileModel) {}

}
