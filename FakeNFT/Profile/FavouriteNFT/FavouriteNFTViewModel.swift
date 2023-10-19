//
//  FavouriteNFTViewModel.swift
//  FakeNFT
//
//  Created by Artem Novikov on 18.10.2023.
//

import Foundation

// MARK: - FavouriteNFTViewModelProtocol
protocol FavouriteNFTViewModelProtocol {
    var nftList: [FavouriteNFTModel]? { get }
    var onNFTListLoaded: (() -> Void)? { get set }
    var onNFTListLoadError: ((String) -> Void)? { get set }
    func viewDidLoad()
    func unlikeNFT(with index: String, completion: @escaping (Result<Void, Error>) -> Void)
}

// MARK: - FavouriteNFTViewModel
final class FavouriteNFTViewModel: FavouriteNFTViewModelProtocol {

    // MARK: - Public properties
    private(set) var nftList: [FavouriteNFTModel]? {
        didSet {
            onNFTListLoaded?()
        }
    }
    var onNFTListLoaded: (() -> Void)?
    var onNFTListLoadError: ((String) -> Void)?

    // MARK: - Private properties
    private let profileService: ProfileServiceProtocol
    private var userDefaults: UserDefaults {
        UserDefaults.standard
    }

    // MARK: - Initializers
    init(profileService: ProfileServiceProtocol = ProfileService()) {
        self.profileService = profileService
    }

    // MARK: - Public methods
    func viewDidLoad() {
        fetchFavouriteNFTs()
    }

    func unlikeNFT(with id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let profile = userDefaults.profile else { return }
        let newLikes = profile.likes.filter { $0 != id }
        let likesModel = LikesModel(likes: newLikes)
        profileService.setLikes(likesModel) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let profile):
                self.updateProfileIfNeeded(profileModel: profile)
                self.fetchFavouriteNFTs()
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private methods
    private func fetchFavouriteNFTs() {
        profileService.getFavouriteNFTs { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let nftModels):
                self.nftList = nftModels
            case .failure(let error):
                self.onNFTListLoadError?(error.localizedDescription)
            }
        }
    }

    private func updateProfileIfNeeded(profileModel: ProfileModel) {
        guard userDefaults.profile != profileModel else { return }
        userDefaults.profile = profileModel
        userDefaults.profileLastChangeTime = Int(Date().timeIntervalSince1970)
    }

}
