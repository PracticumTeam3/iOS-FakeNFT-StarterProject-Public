//
//  NFTService.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 02.11.2023.
//

import Foundation

final class NFTService {
    // MARK: - Private properties
    private var request: GetNFTRequest?
    private let networkClient = DefaultNetworkClient()

    // MARK: - Initializers
    private init() {}

    init(id: String) {
        self.request = GetNFTRequest(id: id)
    }

    // MARK: - Public methods
    func fetchNFT(completion: @escaping(Result<NFTResult, Error>) -> Void) {
        guard let request = request else { return }
        networkClient.send(request: request, type: NFTResult.self) { result in
            switch result {
            case .success(let nft):
                completion(.success(nft))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
