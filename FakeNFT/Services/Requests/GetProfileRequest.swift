//
//  GetProfileRequest.swift
//  FakeNFT
//
//  Created by Artem Novikov on 09.10.2023.
//

import Foundation

struct GetProfileRequest: NetworkRequest {

    var endpoint: URL? {
        Endpoint.profile.url
    }

    var httpMethod: HttpMethod {
        .get
    }

}
