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
    @CartObservable private(set) var nfts = [NftModel]()

    private var currentOrder:OrderModel? {
        didSet {
            fetchNFT()
        }
    }
    
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
            path: CartNetworkPath.orderService.rawValue)
        getOrder(request: request)
    }
    
    func changeOrder(deleteNftId: String) {
        guard let currentOrder = currentOrder else { return }
        var request = URLRequest.makeHTTPRequest(
            path: CartNetworkPath.orderService.rawValue,
            httpMethod: "PUT")
        let newNfts = currentOrder.nfts.filter { $0 != deleteNftId }
        let jsonModel = OrderNetwork(nfts: newNfts, id: currentOrder.id)
        let jsonData = try? JSONEncoder().encode(jsonModel)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        getOrder(request: request)
    }
    
    private func getOrder(request: URLRequest) {
        currentTask?.cancel()
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<OrderNetwork,Error>) in
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
        nftArray = []
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
