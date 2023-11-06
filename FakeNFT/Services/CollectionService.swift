//
//  CollectionService.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 06.11.2023.
//

import Foundation

protocol CollectionServiceProtocol {
    func getUsers(id: String, completion: @escaping (Result<AutorModel, Error>) -> Void)

}

struct CollectionService: CollectionServiceProtocol {
    private let networkClient: NetworkClient

    init(
        networkClient: NetworkClient = DefaultNetworkClient()
    ) {
        self.networkClient = networkClient
    }

    func getUsers(id: String, completion: @escaping (Result<AutorModel, Error>) -> Void) {
        let request = GetUserRequest(id: id)
        networkClient.send(request: request, type: UserNetworkModel.self) { result in
            switch result {
            case .success(let model):
                let model = AutorModel(name: model.name, website: model.website)
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
