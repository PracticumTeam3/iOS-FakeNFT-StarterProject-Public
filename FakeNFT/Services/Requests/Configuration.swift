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

    static let baseURL = URL(string: "https://651ff0bd906e276284c3c180.mockapi.io/")!

    var path: String {
        switch self {
        case .profile: return "api/v1/profile/1"
        case .nftById(let id): return "api/v1/nft/\(id)"
        case .userById(let id): return "api/v1/users/\(id)"
        }
    }

    var url: URL? {
        switch self {
        case .profile: return URL(string: Endpoint.profile.path, relativeTo: Endpoint.baseURL)
        case .nftById(let id): return URL(string: Endpoint.nftById(id: id).path,
                                          relativeTo: Endpoint.baseURL)
        case .userById(let id): return URL(string: Endpoint.userById(id: id).path,
                                          relativeTo: Endpoint.baseURL)
        }
    }
}
