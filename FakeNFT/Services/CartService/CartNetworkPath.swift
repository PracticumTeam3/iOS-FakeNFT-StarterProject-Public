//
//  CartNetworkPath.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 26.10.2023.
//

import Foundation

enum CartNetworkPath: String {
    case orderService = "/api/v1/orders/1"
    case nftService = "/api/v1/nft/"
    case paymentService = "/api/v1/currencies"
    case currencyPay = "/api/v1/orders/1/payment/"
}
