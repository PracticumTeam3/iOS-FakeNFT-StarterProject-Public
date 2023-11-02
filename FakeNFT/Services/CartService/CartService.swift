//
//  CartService.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 30.10.2023.
//

import Foundation

enum NetworkAlert {
    case fetchOrder
    case changeOrder
    case fetchCurrencies
    case payOrder
    case fetchNFT
}

class CartService {
    
    static let shared = CartService()
    private let networkClient: NetworkClient
    @CartObservable private(set) var nfts = [NftModel]()
    @CartObservable private(set) var currencies = [Currency]()
    @CartObservable private(set) var netWorkAlert: NetworkAlert?
    @CartObservable private(set) var loadIsShow: Bool = false

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
        loadIsShow = true
        let request = GetOrderRequest()
        networkClient.send(request: request,
                           type: OrderNetwork.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case (.success(let orderNetwork)):
                let order = OrderModel(nfts: orderNetwork.nfts,
                                       id: orderNetwork.id)
                self.currentOrder = order
                self.netWorkAlert = nil
            case (.failure(let error)):
                print(error.localizedDescription)
                self.loadIsShow = false
                self.netWorkAlert = NetworkAlert.fetchOrder
            }
        }
    }
    
    func changeOrder(deleteNftId: String) {
        loadIsShow = true
        guard let currentOrder = currentOrder else { return }
        let newNfts = currentOrder.nfts.filter { $0 != deleteNftId }
        let orderNetwork = OrderNetwork(nfts: newNfts, id: currentOrder.id)
        let request = SetOrderRequest(model: orderNetwork)
        
        networkClient.send(request: request,
                           type: OrderNetwork.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case (.success(let orderNetwork)):
                let order = OrderModel(nfts: orderNetwork.nfts,
                                       id: orderNetwork.id)
                self.currentOrder = order
                self.netWorkAlert = nil
            case (.failure(let error)):
                print(error.localizedDescription)
                self.loadIsShow = false
                self.netWorkAlert = NetworkAlert.changeOrder
            }
        }
    }
    
    func fetchCurrencies() {
        loadIsShow = true
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
                self.loadIsShow = false
                self.netWorkAlert = nil
            case .failure(let error):
                print(error.localizedDescription)
                self.loadIsShow = false
                self.netWorkAlert = NetworkAlert.fetchCurrencies
            }
        }
    }
    
    func payOrder(_ currencyID: String, completion: @escaping (Result <ResultOrder, Error>) -> Void) {
        loadIsShow = true
        let request = GetResultOrderRequest(id: currencyID)
        networkClient.send(request: request,
                           type: ResultOrderNetwork.self) { result in
            switch result {
            case (.success(let resultOrderNetwork)):
                let resultOrder = ResultOrder(success: resultOrderNetwork.success,
                                              orderId: resultOrderNetwork.orderId,
                                              currencyId: resultOrderNetwork.currencyId)
                self.netWorkAlert = nil
                self.loadIsShow = false
                completion(.success(resultOrder))
            case .failure(let error):
                self.loadIsShow = false
                self.netWorkAlert = NetworkAlert.payOrder
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
                            if nftId == nftsOrder.last {
                                self.loadIsShow = false
                                self.netWorkAlert = nil
                            }
                            self.nftArray.append(nftModel)
                        case (.failure(let error)):
                            self.loadIsShow = false
                            self.netWorkAlert = NetworkAlert.fetchNFT
                            print(error.localizedDescription)
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
                self.netWorkAlert = nil
                completion(.success(nftModel))
            case .failure(let error):
                self.netWorkAlert = NetworkAlert.fetchNFT
                completion(.failure(error))
            }
        }
    }
        
}
