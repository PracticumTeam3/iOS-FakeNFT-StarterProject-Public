//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Artem Novikov on 05.10.2023.
//

import Foundation

// MARK: - ProfileViewModel
final class ProfileViewModel {

    // MARK: - Public properties
    var onProfileInfoChanged: (() -> Void)?
    var onFetchError: ((String) -> Void)?
    var onEditError: ((String) -> Void)?

    var model: ProfileModel? {
        userDefaults.profile
    }

    var cells: [ProfileTableViewCells] {
        [
            .myNFT(model?.nfts.count ?? 0),
            .favouriteNFT(model?.likes.count ?? 0),
            .about
        ]
    }

    // MARK: - Private properties
    private let profileService: ProfileServiceProtocol
    private var profileObservation: NSKeyValueObservation?
    private var userDefaults: UserDefaults {
        UserDefaults.standard
    }

    // MARK: - Initializers
    init(profileService: ProfileServiceProtocol = ProfileService()) {
        self.profileService = profileService
        registerProfileLastChangeTimeObserver()
    }

    // MARK: - Public methods
    func fetchProfile() {
        profileService.fetchProfile { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let model): self.updateProfileIfNeeded(profileModel: model)
            case .failure(let error): self.onFetchError?(error.localizedDescription)
            }
        }
    }

    func editProfile(editProfileModel: EditProfileModel) {
        profileService.editProfile(editProfileModel) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let model): self.updateProfileIfNeeded(profileModel: model)
            case .failure(let error): self.onEditError?(error.localizedDescription)
            }
        }
    }

    // MARK: - Private methods
    private func updateProfileIfNeeded(profileModel: ProfileModel) {
        guard userDefaults.profile != profileModel else { return }
        userDefaults.profile = profileModel
        userDefaults.profileLastChangeTime = Int(Date().timeIntervalSince1970)
        onProfileInfoChanged?()
    }

    private func registerProfileLastChangeTimeObserver() {
        profileObservation = userDefaults.observe(
            \.profileLastChangeTime,
             options: []
        ) { [weak self] _, _ in
            guard let self else { return }
            self.onProfileInfoChanged?()
        }
    }

}
