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
    func fetchFavouriteNFTs(completion: @escaping (Result<Void, Error>) -> Void)
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
    private let storageService: StorageService

    // MARK: - Initializers
    init(
        profileService: ProfileServiceProtocol = ProfileService(),
        storageService: StorageService = StorageService.shared
    ) {
        self.profileService = profileService
        self.storageService = storageService
    }

    // MARK: - Public methods
    func unlikeNFT(with id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let profile = storageService.profile else { return }
        let newLikes = profile.likes.filter { $0 != id }
        let likesModel = LikesModel(likes: newLikes)
        profileService.setLikes(likesModel) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let profile):
                self.updateProfileIfNeeded(profileModel: profile)
                self.fetchFavouriteNFTs { _ in }
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchFavouriteNFTs(completion: @escaping (Result<Void, Error>) -> Void) {
        profileService.getFavouriteNFTs { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let nftModels):
                self.nftList = nftModels
                completion(.success(()))
            case .failure(let error):
                self.onNFTListLoadError?(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    private func updateProfileIfNeeded(profileModel: ProfileModel) {
        guard storageService.profile != profileModel else { return }
        storageService.profile = profileModel
    }

}