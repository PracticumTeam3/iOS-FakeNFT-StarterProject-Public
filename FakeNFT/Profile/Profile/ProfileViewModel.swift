//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by Artem Novikov on 05.10.2023.
//

import Foundation

// MARK: - ProfileViewModelProtocol
protocol ProfileViewModelProtocol: AnyObject {
    var onProfileInfoChanged: (() -> Void)? { get set }
    var onFetchError: ((String) -> Void)? { get set }
    var onEditError: ((String) -> Void)? { get set }
    var model: ProfileModel? { get }
    var cells: [ProfileTableViewCells] { get }

    func fetchProfile(completion: @escaping (Result<Void, Error>) -> Void)
    func editProfile(editProfileModel: EditProfileModel)
}

// MARK: - ProfileViewModel
final class ProfileViewModel: ProfileViewModelProtocol {

    // MARK: - Public properties
    var onProfileInfoChanged: (() -> Void)? {
        didSet {
            storageService.onProfileInfoChanged = onProfileInfoChanged
        }
    }
    var onFetchError: ((String) -> Void)?
    var onEditError: ((String) -> Void)?

    var model: ProfileModel? {
        storageService.profile
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
    private let storageService: StorageServiceProtocol
    private var profileObservation: NSKeyValueObservation?

    // MARK: - Initializers
    init(
        profileService: ProfileServiceProtocol = ProfileService(),
        storageService: StorageServiceProtocol = StorageService.shared
    ) {
        self.storageService = storageService
        self.profileService = profileService
    }

    // MARK: - Public methods
    func fetchProfile(completion: @escaping (Result<Void, Error>) -> Void) {
        profileService.fetchProfile { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let model):
                self.updateProfileIfNeeded(profileModel: model)
                completion(.success(()))
            case .failure(let error):
                self.onFetchError?(error.localizedDescription)
                completion(.failure(error))
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
        guard storageService.profile != profileModel else { return }
        storageService.profile = profileModel
        onProfileInfoChanged?()
    }

}
