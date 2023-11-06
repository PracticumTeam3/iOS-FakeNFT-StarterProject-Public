//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 19.10.2023.
//

import Foundation

class CatalogViewModel {
    let service = CatalogService(networkClient: DefaultNetworkClient())

    var onChange: (() -> Void)?
    var collections: [CatalogCellModel] = [] {
        didSet {
            onChange?()
        }
    }

    func getCollections () {
        service.getCollections { result in
            switch result {
            case .success(let model):
                self.collections = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
