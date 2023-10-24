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
    
    private var selectedCoin:Int? {
        didSet {
            checkSelectedCoin()
        }
    }
    
    private let coinsService = mockCoins
    
    init(selectedCoin: Int? = nil) {
        self.coins = coinsService
        self.selectedCoin = selectedCoin
        checkSelectedCoin()
    }
    
    func changeSelectedCoin(index: Int) {
        self.selectedCoin = index
    }
    
    private func checkSelectedCoin() {
        if selectedCoin != nil {
            isSelectedCoin = true
        } else {
            isSelectedCoin = false
        }
    }
}

/*
 Mock data for PaymentCellViewModel
 */

let bitcoinViewModel = PaymentCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Bitcoin_(BTC).png")!,
                                            coinName: "Bitcoin",
                                            coinShortName: "BTC")
let dogeCoinViewModel = PaymentCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Dogecoin_(DOGE).png")!,
                                             coinName: "Dogecoin",
                                             coinShortName: "DOGE")
let tetherCoinViewModel = PaymentCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Tether_(USDT).png")!,
                                             coinName: "Tether",
                                             coinShortName: "USDT")
let apecoinCoinViewModel = PaymentCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/ApeCoin_(APE).png")!,
                                             coinName: "Apecoin",
                                             coinShortName: "APE")
let solanaCoinViewModel = PaymentCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Solana_(SOL).png")!,
                                             coinName: "Solana",
                                             coinShortName: "SOL")
let ethereumCoinViewModel = PaymentCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Ethereum_(ETH).png")!,
                                             coinName: "Etherium",
                                             coinShortName: "ETH")
let cardanoCoinViewModel = PaymentCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Cardano_(ADA).png")!,
                                             coinName: "Cardano",
                                             coinShortName: "ADA")
let shibaCoinViewModel = PaymentCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/Currencies/Shiba_Inu_(SHIB).png")!,
                                             coinName: "Shiba lnu",
                                             coinShortName: "SHIB")
let mockCoins = [bitcoinViewModel, dogeCoinViewModel,
                 tetherCoinViewModel, apecoinCoinViewModel,
                 solanaCoinViewModel, ethereumCoinViewModel,
                 cardanoCoinViewModel, shibaCoinViewModel]
