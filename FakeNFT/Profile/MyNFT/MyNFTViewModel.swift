//
//  MyNFTViewModel.swift
//  FakeNFT
//
//  Created by Artem Novikov on 11.10.2023.
//

import Foundation

// MARK: - MyNFTViewModelProtocol
protocol MyNFTViewModelProtocol {
    var nftList: [NFTModel]? { get }
    var onNFTListLoaded: (() -> Void)? { get set }
    var onNFTListLoadError: ((String) -> Void)? { get set }
    var sortType: SortType { get set }
    func fetchNFTs(completion: @escaping (Result<Void, Error>) -> Void)
}

// MARK: - MyNFTViewModel
final class MyNFTViewModel: MyNFTViewModelProtocol {

    // MARK: - Public properties
    private(set) var nftList: [NFTModel]? {
        didSet {
            onNFTListLoaded?()
        }
    }
    var onNFTListLoaded: (() -> Void)?
    var onNFTListLoadError: ((String) -> Void)?
    var sortType: SortType {
        get { storageService.sortType }
        set {
            storageService.sortType = newValue
            sortNFTList()
        }
    }

    // MARK: - Private properties
    private let storageService: StorageService
    private let profileService: ProfileServiceProtocol

    // MARK: - Initializers
    init(
        profileService: ProfileServiceProtocol = ProfileService(),
        storageService: StorageService = StorageService.shared
    ) {
        self.storageService = storageService
        self.profileService = profileService
    }

    // MARK: - Public methods   
    func fetchNFTs(completion: @escaping (Result<Void, Error>) -> Void) {
        profileService.getNFTs { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let nftModels):
                self.nftList = nftModels
                self.sortNFTList()
                completion(.success(()))
            case .failure(let error):
                self.onNFTListLoadError?(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private methods
    private func sortNFTList() {
        switch sortType {
        case .byPrice:
            self.nftList?.sort { $0.price > $1.price }
        case .byRating:
            self.nftList?.sort { $0.rating > $1.rating }
        case .byName:
            self.nftList?.sort { $0.name < $1.name }
        }
    }

}
