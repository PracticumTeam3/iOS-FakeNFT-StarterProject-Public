//
//  PaymentViewViewModel.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 18.10.2023.
//

import Foundation

final class PaymentViewViewModel {

    @CartObservable private(set) var coins: [PaymentCellViewModel] = []
    @CartObservable private(set) var isSelectedCoin:Bool = false
    @CartObservable private(set) var progressHUDIsActive: Bool = true
    @CartObservable private(set) var showNetWorkError: Bool?

    private let cartService = CartService.shared
    private(set) var selectedCoin: String? {
        didSet {
            checkSelectedCoin()
        }
    }

    init(selectedCoin: String? = nil) {
        fetchCoins()
        checkProgress(cartService.loadIsShow)
        self.selectedCoin = selectedCoin
        checkSelectedCoin()
        bind()
        checkAlert(cartService.netWorkAlert)
    }

    func fetchCoins() {
        cartService.fetchCurrencies()
        DispatchQueue.main.async {
            self.coins = self.currenciesToCoins(self.cartService.currencies)
        }
    }

    func changeSelectedCoin(id: String) {
        self.selectedCoin = id
    }

    func pressPay(completion: @escaping (Result<Bool,Error>) -> Void) {
        guard let selectedCoin = selectedCoin else { return }
        cartService.payOrder(selectedCoin) { result in
            switch result {
            case (.success(let resultOrder)):
                if resultOrder.success {
                    completion(.success(true))
                } else {
                   completion(.success(false))
                }
            case (.failure(let error)):
                completion(.failure(error))
            }
        }
    }

    private func checkSelectedCoin() {
        isSelectedCoin = selectedCoin != nil
    }

    private func bind() {
        cartService.$currencies.bind { [weak self] newCurrencies in
            guard let self else { return }
            self.coins = self.currenciesToCoins(newCurrencies)
            self.progressHUDIsActive = false
        }
        cartService.$netWorkAlert.bind { [weak self] netWorkAlert in
            self?.checkAlert(netWorkAlert)
            self?.progressHUDIsActive = false
        }
        cartService.$loadIsShow.bind { [weak self] loading in
            self?.checkProgress(loading)
        }
    }

    private func checkAlert(_ netWorkAlert: NetworkAlert?) {
        guard let netWorkAlert else {
            self.showNetWorkError = nil
            return
        }
        switch netWorkAlert {
        case .payOrder, .fetchCurrencies:
            self.showNetWorkError = true
        default:
            self.showNetWorkError = false
        }
    }

    private func checkProgress(_ loading: Loading?) {
        guard let loading else {
            self.progressHUDIsActive = false
            return
        }
        switch loading {
        case .fetchCurrencies, .payOrder:
            self.progressHUDIsActive = true
        default:
            self.progressHUDIsActive = false
        }
    }

    private func currenciesToCoins(_ currencies: [Currency]) -> [PaymentCellViewModel] {
        return currencies.compactMap { PaymentCellViewModel(imageURL: $0.imageURL,
                                                            coinName: $0.title,
                                                            coinShortName: $0.name,
                                                            id:$0.id) }
    }
}

/*
 // Mock data for PaymentCellViewModel
let btcImageURL = URL(string:"https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png")!
let dogeCoinImageURL = URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Dogecoin_(DOGE).png")!
let tetherImageURL = URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Tether_(USDT).png")!
let apecoinImageURL = URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/ApeCoin_(APE).png")!
let solanaCoinImageURL = URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Solana_(SOL).png")!
let ethereumImageURL = URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Ethereum_(ETH).png")!
let cardanoImageURL = URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Cardano_(ADA).png")!
let shibaImageURL = URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Shiba_Inu_(SHIB).png")!
 
let bitcoinViewModel = PaymentCellViewModel(imageURL: btcImageURL,
                                            coinName: "Bitcoin",
                                            coinShortName: "BTC",
                                            id:"1")
let dogeCoinViewModel = PaymentCellViewModel(imageURL: dogeCoinImageURL,
                                             coinName: "Dogecoin",
                                             coinShortName: "DOGE",
                                             id:"2")
let tetherCoinViewModel = PaymentCellViewModel(imageURL: tetherImageURL,
                                               coinName: "Tether",
                                               coinShortName: "USDT",
                                               id:"3")
let apecoinCoinViewModel = PaymentCellViewModel(imageURL: apecoinImageURL,
                                                coinName: "Apecoin",
                                                coinShortName: "APE",
                                                id:"4")
let solanaCoinViewModel = PaymentCellViewModel(imageURL: solanaCoinImageURL,
                                               coinName: "Solana",
                                               coinShortName: "SOL",
                                               id:"5")
let ethereumCoinViewModel = PaymentCellViewModel(imageURL: ethereumImageURL,
                                                 coinName: "Etherium",
                                                 coinShortName: "ETH",
                                                 id:"6")
let cardanoCoinViewModel = PaymentCellViewModel(imageURL: cardanoImageURL,
                                                coinName: "Cardano",
                                                coinShortName: "ADA",
                                                id:"7")
let shibaCoinViewModel = PaymentCellViewModel(imageURL: shibaImageURL,
                                              coinName: "Shiba lnu",
                                              coinShortName: "SHIB",
                                              id:"8")
let mockCoins = [bitcoinViewModel, dogeCoinViewModel,
                 tetherCoinViewModel, apecoinCoinViewModel,
                 solanaCoinViewModel, ethereumCoinViewModel,
                 cardanoCoinViewModel, shibaCoinViewModel]
*/
