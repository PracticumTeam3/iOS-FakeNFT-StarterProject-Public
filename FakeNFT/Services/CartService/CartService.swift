//
//  CartService.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 30.10.2023.
//

import Foundation

enum CartServiceNetWorkError: Error {
    case fetchOrder(error: Error)
    case fetchNFT(error: Error)
    case changeOrder(error: Error)
    case fetchCurrencies(error: Error)
    case payOrder(error: Error)
}

class CartService {
    
    static let shared = CartService()
    private let networkClient: NetworkClient
    @CartObservable private(set) var nfts = [NftModel]()
    @CartObservable private(set) var currencies = [Currency]()

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
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchOrder() {
        let request = GetOrderRequest()
        networkClient.send(request: request,
                           type: OrderNetwork.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case (.success(let orderNetwork)):
                let order = OrderModel(nfts: orderNetwork.nfts,
                                       id: orderNetwork.id)
                self.currentOrder = order
            case (.failure(let error)):
                CartServiceNetWorkError.fetchOrder(error: error)
                print(error.localizedDescription)
            }
        }
    }
    
    func changeOrder(deleteNftId: String) {
        guard let currentOrder = currentOrder else { return }
        let newNfts = currentOrder.nfts.filter { $0 != deleteNftId }
        let orderNetwork = OrderNetwork(nfts: newNfts, id: currentOrder.id)
        var request = SetOrderRequest(model: orderNetwork)
        
        networkClient.send(request: request,
                           type: OrderNetwork.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case (.success(let orderNetwork)):
                let order = OrderModel(nfts: orderNetwork.nfts,
                                       id: orderNetwork.id)
                self.currentOrder = order
            case (.failure(let error)):
                CartServiceNetWorkError.changeOrder(error: error)
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCurrencies() {
        let request = GetCurrencyRequest()
        networkClient.send(request: request,
                           type: [CurrencyNetwork].self) { [weak self] result in
            guard let self else { return }
            switch result {
            case (.success(let currenciesNetwork)):
                let currencies = currenciesNetwork.compactMap { Currency(title: $0.title,
                                                                       name: $0.name,
                                                                       image: $0.image,
                                                                       id: $0.id)}
                self.currencies = currencies
            case .failure(let error):
                CartServiceNetWorkError.fetchCurrencies(error: error)
                print(error)
            }
        }
    }
    
    func payOrder(_ currencyID: String, completion: @escaping (Result <ResultOrder, Error>) -> Void) {
        let request = GetResultOrderRequest(id: currencyID)
        networkClient.send(request: request,
                           type: ResultOrderNetwork.self) { result in
            switch result {
            case (.success(let resultOrderNetwork)):
                let resultOrder = ResultOrder(success: resultOrderNetwork.success,
                                              orderId: resultOrderNetwork.orderId,
                                              currencyId: resultOrderNetwork.currencyId)
                completion(.success(resultOrder))
            case .failure(let error):
                CartServiceNetWorkError.payOrder(error: error)
                completion(.failure(error))
            }
        }
    }
    
    private func fetchNFT() {
        guard let nftsOrder = currentOrder?.nfts else { return }
        nftArray = []
        if !nftsOrder.isEmpty {
            let dispathGroup = DispatchGroup()
            for nftId in nftsOrder {
                dispathGroup.enter()
                DispatchQueue.global().async {
                    self.getNFT(id: nftId) { result in
                        switch result {
                        case (.success(let nftModel)):
                            self.nftArray.append(nftModel)
                        case (.failure(let error)):
                            CartServiceNetWorkError.fetchNFT(error: error)
                            print(error)
                        }
                    }
                    dispathGroup.leave()
                }
            }
        }
    }
    
    private func getNFT(id: String, completion: @escaping (Result<NftModel,Error>) -> Void ) {
        let nftRequest = GetNFTRequest(id: id)
        networkClient.send(request: nftRequest, type: NftNetwork.self) { result in
            switch result {
            case .success(let nftNetwork):
                let nftModel = NftModel(name: nftNetwork.name,
                                        images: nftNetwork.images,
                                        rating: nftNetwork.rating,
                                        price: nftNetwork.price,
                                        id: nftNetwork.id)
                completion(.success(nftModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
        
}

