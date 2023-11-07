//
//  Configuration.swift
//  FakeNFT
//
//  Created by Artem Novikov on 10.10.2023.
//

import Foundation

enum Endpoint {

    case profile
    case nftById(id: String)
    case userById(id: String)
    case order
    case currencies
    case paymentById(id: String)

    static var baseURL: URL {
        switch StorageService.shared.environment {
        case .prod:
            return URL(string: "https://651ff0bd906e276284c3c180.mockapi.io/")!
        case .test:
            return URL(string: "http://127.0.0.1:9080/")!
        }
    }

    var path: String {
        switch self {
        case .profile: return "api/v1/profile/1"
        case .nftById(let id): return "api/v1/nft/\(id)"
        case .userById(let id): return "api/v1/users/\(id)"
        case .order: return "/api/v1/orders/1"
        case .currencies: return "/api/v1/currencies"
        case .paymentById(let id): return "/api/v1/orders/1/payment/\(id)"
        }
    }

    var url: URL? {
        switch self {
        case .profile: return URL(string: Endpoint.profile.path, relativeTo: Endpoint.baseURL)
        case .nftById(let id): return URL(string: Endpoint.nftById(id: id).path,
                                          relativeTo: Endpoint.baseURL)
        case .userById(let id): return URL(string: Endpoint.userById(id: id).path,
                                           relativeTo: Endpoint.baseURL)
        case .order: return URL(string: Endpoint.order.path,
                                relativeTo: Endpoint.baseURL)
        case .currencies: return URL(string: Endpoint.currencies.path,
                                     relativeTo: Endpoint.baseURL)
        case .paymentById(let id): return URL(string: Endpoint.paymentById(id: id).path,
                                              relativeTo: Endpoint.baseURL)
        }
    }

}
