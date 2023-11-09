//
//  CollectionNFTViewModel.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 03.11.2023.
//

import Foundation

protocol CollectionNFTViewModelDelegate: AnyObject {
    func showAlertNftModel()
}

protocol CollectionNFTViewModelProtocol {
    var nfts: [NFTResult] { get }
    var nftIDs: [String] { get }
    var delegate: CollectionNFTViewModelDelegate? { get set}
    init(nftIDs: [String])
    func nftsIsEmpty() -> Bool
    func numberOfRows() -> Int
    func fetchNFT(completion: @escaping() -> Void)
    var onChange: (() -> Void)? { get set }
    func cellViewModel(
        at indexPath: IndexPath,
        delegate: CollectionNFTCellViewModelDelegate
    ) -> CollectionNFTCellViewModel
}

final class CollectionNFTViewModel: CollectionNFTViewModelProtocol {
    // MARK: - Public properties
    var onChange: (() -> Void)?
    var nfts: [NFTResult] = [] {
        didSet {
            onChange?()
        }
    }
    weak var delegate: CollectionNFTViewModelDelegate?
    let nftIDs: [String]
    var service: NFTService?

    // MARK: - init
    init(nftIDs: [String]) {
        self.nftIDs = nftIDs
    }

    // MARK: - Public methods
    func fetchNFT(completion: @escaping() -> Void) {
        let dGroup = DispatchGroup()
        var nftsGroup = [NFTResult]()

        for id in nftIDs {
            dGroup.enter()
            let nftservice = NFTService(id: id)
            nftservice.fetchNFT { result in
                switch result {
                case .success(let nft):
                    if !nft.images.isEmpty {
                        nftsGroup.append(nft)
                    }
                    dGroup.leave()
                case .failure:
                    DispatchQueue.main.async {
                        self.delegate?.showAlertNftModel()
                    }
                }
            }
        }

        dGroup.notify(queue: .main) {
            nftsGroup.sort { $0.name < $1.name }
            self.nfts = nftsGroup
            completion()
        }
    }

    func cellViewModel(
        at indexPath: IndexPath,
        delegate: CollectionNFTCellViewModelDelegate
    ) -> CollectionNFTCellViewModel {
        return CollectionNFTCellViewModel(
            nft: nfts[indexPath.row],
            indexPath: indexPath,
            delegate: delegate
        )
    }

    func numberOfRows() -> Int {
        nfts.count
    }

    func nftsIsEmpty() -> Bool {
        nfts.isEmpty
    }
}
