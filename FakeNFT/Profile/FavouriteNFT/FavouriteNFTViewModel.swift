//
//  FavouriteNFTViewModel.swift
//  FakeNFT
//
//  Created by Artem Novikov on 18.10.2023.
//

import Foundation

// MARK: - FavouriteNFTViewModelProtocol
protocol FavouriteNFTViewModelProtocol {
    var state: FavouriteNFTViewModel.State { get set }
    var nftList: [FavouriteNFTModel]? { get }
    var onNFTListLoaded: (() -> Void)? { get set }
    var onNFTListLoadError: ((String) -> Void)? { get set }

    func fetchFavouriteNFTs(completion: @escaping (Result<Void, Error>) -> Void)
    func unlikeNFT(with index: String, completion: @escaping (Result<Void, Error>) -> Void)
}

// MARK: - FavouriteNFTViewModel
final class FavouriteNFTViewModel: FavouriteNFTViewModelProtocol {

    // MARK: - Public properties
    enum State {
        case search(searchText: String?)
        case standart
    }

    private(set) var nftList: [FavouriteNFTModel]? {
        didSet {
            onNFTListLoaded?()
        }
    }
    var onNFTListLoaded: (() -> Void)?
    var onNFTListLoadError: ((String) -> Void)?

    var state: State {
        get { currentState }
        set {
            currentState = newValue
            filterNFTsIfNeeded()
        }
    }

    // MARK: - Private properties
    private let profileService: ProfileServiceProtocol
    private let storageService: StorageServiceProtocol
    private var loadedNFTs: [FavouriteNFTModel]?
    private var currentState: State = .standart

    // MARK: - Initializers
    init(
        profileService: ProfileServiceProtocol = ProfileService(),
        storageService: StorageServiceProtocol = StorageService.shared
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
                self.fetchFavouriteNFTs { result in
                    switch result {
                    case .success: completion(.success(()))
                    case .failure(let error): completion(.failure(error))
                    }
                }
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
                self.loadedNFTs = nftModels
                self.filterNFTsIfNeeded()
                completion(.success(()))
            case .failure(let error):
                self.onNFTListLoadError?(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private methods
    private func filterNFTsIfNeeded() {
        switch currentState {
        case .search(let searchText):
            self.searchNFTs(searchText: searchText)
        case .standart:
            self.nftList = loadedNFTs
        }
    }

    private func searchNFTs(searchText: String?) {
        guard let searchText, !searchText.isEmpty else {
            nftList = loadedNFTs
            return
        }
        nftList = loadedNFTs?.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    private func updateProfileIfNeeded(profileModel: ProfileModel) {
        guard storageService.profile != profileModel else { return }
        storageService.profile = profileModel
    }

}
