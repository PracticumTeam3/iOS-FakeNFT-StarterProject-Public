//
//  NftService.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 25.10.2023.
//

import Foundation

final class NftService {
    private let urlSession = URLSession.shared
    
    private enum NetWorkError: Error {
        case codeError
    }
    
    func fetchNft(nftId: String, completion: @escaping(Result<NftModel,Error>) -> Void) {
        let request = URLRequest.makeHTTPRequest(
            path: CartNetworkPath.nftService.rawValue + nftId)
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<NftNetwork,Error>) in
            guard self != nil else { return }
            switch result {
            case.success(let nftResult):
                let nftModel = NftModel(name: nftResult.name,
                                        images: nftResult.images,
                                        rating: nftResult.rating,
                                        price: nftResult.price,
                                        id: nftResult.id)
                completion(.success(nftModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
