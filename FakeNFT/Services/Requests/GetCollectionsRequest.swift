//
//  GetCollectionsRequest.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 01.11.2023.
//

import Foundation

struct GetCollectionsRequest: NetworkRequest {
    var endpoint: URL? {
        Endpoint.collections.url
    }
    var httpMethod: HttpMethod {
        .get
    }
}
