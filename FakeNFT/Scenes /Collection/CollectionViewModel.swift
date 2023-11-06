//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 28.10.2023.
//

import Foundation

final class CollectionViewModel {
    let service = CollectionService(networkClient: DefaultNetworkClient())
    var onChange: (() -> Void)?
    var author: AutorModel? {
        didSet {
            onChange?()
        }
    }

    var NFT: [String:NFTCollectionModel] = [:] {
        didSet {
            onChange?()
        }
    }

    func getUsers (id: String) {
        service.getUsers(id: id) { result in
            switch result {
            case .success(let model):
                self.author = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getNFT (id: String) {
        service.getNFT(id: id) { result in
            switch result {
            case .success(let model):
                self.NFT[id] = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getNFTs (nfts:[String]) {
        nfts.forEach { id in
            getNFT(id:id)
        }
    }
}
