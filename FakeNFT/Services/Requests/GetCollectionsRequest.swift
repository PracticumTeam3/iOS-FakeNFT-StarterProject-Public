//
//  GetCollectionsRequest.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 01.11.2023.
//

import Foundation
struct GetCollectionsRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "https://651ff0bd906e276284c3c180.mockapi.io/api/v1/collections")
    }
    var httpMethod: HttpMethod {
        .get
    }
}
