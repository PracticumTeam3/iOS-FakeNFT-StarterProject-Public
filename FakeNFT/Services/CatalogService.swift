//
//  CatalogService.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 01.11.2023.
//

import Foundation

protocol CatalogServiceProtocol {
    func getCollections(completion: @escaping (Result<[CatalogCellModel], Error>) -> Void)

}

struct CatalogService: CatalogServiceProtocol {

    private let networkClient: NetworkClient

    init(
        networkClient: NetworkClient = DefaultNetworkClient()
    ) {
        self.networkClient = networkClient
    }

    func getCollections(completion: @escaping (Result<[CatalogCellModel], Error>) -> Void) {
        let request = GetCollectionsRequest()
        networkClient.send(request: request, type: [CatalogNetworkModel].self) { result in
            switch result {
            case .success(let model):
                let model = model.map { collection in
                    CatalogCellModel(imageCollection: collection.cover, collectionName: collection.name, nftCount: collection.nfts.count,author: collection.author, description: collection.description, nfts: collection.nfts)
                }
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
