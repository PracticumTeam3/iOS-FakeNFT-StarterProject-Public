//
//  FavouriteNFTViewModelSpy.swift
//  FakeNFTTests
//
//  Created by Artem Novikov on 01.11.2023.
//

@testable import FakeNFT

// MARK: - FavouriteNFTViewModelSpy
final class FavouriteNFTViewModelSpy: FavouriteNFTViewModelProtocol {

    var isFetchFavouriteNFTsCalled = false

    var state: FavouriteNFTViewModel.State = .standart
    var nftList: [FavouriteNFTModel]?

    var onNFTListLoaded: (() -> Void)?
    var onNFTListLoadError: ((String) -> Void)?

    func fetchFavouriteNFTs(completion: @escaping (Result<Void, Error>) -> Void) {
        isFetchFavouriteNFTsCalled = true
    }

    func unlikeNFT(with index: String, completion: @escaping (Result<Void, Error>) -> Void) {}

}
