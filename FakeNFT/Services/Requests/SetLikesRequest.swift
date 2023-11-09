//
//  SetLikesRequest.swift
//  FakeNFT
//
//  Created by Artem Novikov on 18.10.2023.
//

import Foundation

struct SetLikesRequest: NetworkRequest {

    let model: LikesModel

    var endpoint: URL? {
        Endpoint.profile.url
    }

    var httpMethod: HttpMethod {
        .put
    }

    var dto: Encodable? {
        model
    }

    init(model: LikesModel) {
        self.model = model
    }

}
