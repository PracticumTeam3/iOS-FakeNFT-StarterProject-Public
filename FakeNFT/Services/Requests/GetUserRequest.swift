//
//  GetUserRequest.swift
//  FakeNFT
//
//  Created by Artem Novikov on 12.10.2023.
//

import Foundation

struct GetUserRequest: NetworkRequest {

    let id: String

    var endpoint: URL? {
        Endpoint.userById(id: self.id).url
    }

    var httpMethod: HttpMethod {
        .get
    }

    init(id: String) {
        self.id = id
    }

}
