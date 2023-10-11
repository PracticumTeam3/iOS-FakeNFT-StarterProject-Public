//
//  Configuration.swift
//  FakeNFT
//
//  Created by Artem Novikov on 10.10.2023.
//

import Foundation

enum Endpoint {
    case profile

    static let baseURL = URL(string: "https://651ff0bd906e276284c3c180.mockapi.io/")!

    var path: String {
        switch self {
        case .profile: return "api/v1/profile/1"
        }
    }

    var url: URL? {
        switch self {
        case .profile: return URL(string: Endpoint.profile.path, relativeTo: Endpoint.baseURL)
        }
    }
}
