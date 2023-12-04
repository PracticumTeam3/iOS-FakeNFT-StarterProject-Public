//
//  MyNFTViewModelSpy.swift
//  FakeNFTTests
//
//  Created by Artem Novikov on 01.11.2023.
//

@testable import FakeNFT

// MARK: - MyNFTViewModelSpy
final class MyNFTViewModelSpy: MyNFTViewModelProtocol {

    var isFetchNFTsCalled = false

    var nftList: [NFTModel]?
    var sortType: SortType = .byName

    var onNFTListLoaded: (() -> Void)?
    var onNFTListLoadError: ((String) -> Void)?

    func searchNFTs(searchText: String?) {}

    func fetchNFTs(completion: @escaping (Result<Void, Error>) -> Void) {
        isFetchNFTsCalled = true
    }

}
