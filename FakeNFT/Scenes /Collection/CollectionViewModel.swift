//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 28.10.2023.
//

import Foundation

class CollectionViewModel {
    let service = CollectionService(networkClient: DefaultNetworkClient())
    var onChange: (() -> Void)?
    var author: AutorModel? = nil {
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
}
