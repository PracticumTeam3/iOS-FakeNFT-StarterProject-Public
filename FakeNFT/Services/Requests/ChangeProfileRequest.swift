//
//  ChangeProfileRequest.swift
//  FakeNFT
//
//  Created by Artem Novikov on 10.10.2023.
//

import Foundation

struct ChangeProfileRequest: NetworkRequest {

    let model: EditProfileModel

    var endpoint: URL? {
        Endpoint.profile.url
    }

    var httpMethod: HttpMethod {
        .put
    }

    var dto: Encodable? {
        model
    }

    init(model: EditProfileModel) {
        self.model = model
    }

}
