//
//  OrderService.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 25.10.2023.
//

import Foundation

final class OrderService {
    static let shared = OrderService()
    private let nftService = NftService()
    private let urlSession = URLSession.shared
    private var currentTask: URLSessionTask?
    private var currentOrder:OrderModel? {
        didSet {
            fetchNFT()
        }
    }
    @CartObservable private(set) var nfts = [NftModel]()
    private var nftArray = [NftModel]() {
        didSet {
            guard let currentOrder = currentOrder else { return }
            if currentOrder.nfts.count == nftArray.count {
                self.nfts = nftArray
            }
        }
    }
    
    private enum NetWorkError: Error {
        case codeError
    }
    
    func fetchOrder() {
        
        let request = URLRequest.makeHTTPRequest(
            path: "/api/v1/orders/1",
            httpMethod: "GET")
        currentTask?.cancel()
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<OrderResult,Error>) in
            guard let self else { return }
            switch result {
            case.success(let orderResult):
                let order = OrderModel(nfts: orderResult.nfts,
                                       id: orderResult.id)
                self.currentOrder = order
            case .failure(let error):
                print(error)
            }
        }
        currentTask = task
        currentTask?.resume()
    }
    
    private func fetchNFT() {
        guard let nftsOrder = currentOrder?.nfts else { return }
        if !nftsOrder.isEmpty {
            let dispathGroup = DispatchGroup()
            for nftId in nftsOrder {
                dispathGroup.enter()
                DispatchQueue.global().async {
                    self.nftService.fetchNft(nftId: nftId) { result in
                        switch result {
                        case (.success(let nftModel)):
                            self.nftArray.append(nftModel)
                        case (.failure(let error)):
                            print(error)
                        }
                    }
                    dispathGroup.leave()
                }
            }
        }
    }
    
}
