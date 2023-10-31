//
//  Configuration.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 30.10.2023.
//

import Foundation

enum Endpoint {
    case order
    case nftById(id: String)
    case currencies
    case paymentById(id: String)

    static let baseURL = URL(string: "https://651ff0bd906e276284c3c180.mockapi.io/")!

    var path: String {
        switch self {
        case .order: return "/api/v1/orders/1"
        case .nftById(let id): return "api/v1/nft/\(id)"
        case .currencies: return "/api/v1/currencies"
        case .paymentById(let id): return "/api/v1/orders/1/payment/\(id)"
        }
    }

    var url: URL? {
        switch self {
        case .order: return URL(string: Endpoint.order.path,
                                relativeTo: Endpoint.baseURL)
        case .nftById(let id): return URL(string: Endpoint.nftById(id: id).path,
                                          relativeTo: Endpoint.baseURL)
        case .currencies: return URL(string: Endpoint.currencies.path,
                                     relativeTo: Endpoint.baseURL)
        case .paymentById(let id): return URL(string: Endpoint.paymentById(id: id).path,
                                          relativeTo: Endpoint.baseURL)
        }
    }
}
