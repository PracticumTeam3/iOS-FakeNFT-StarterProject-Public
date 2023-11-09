//
//  SetNftsRequest.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 06.11.2023.
//

import Foundation

struct SetNftsRequest: NetworkRequest {
    var endpoint: URL? {
        Endpoint.profile.url
    }
    var httpMethod: HttpMethod = .put
    var dto: Encodable?

    init(model: ProfileNftsModel) {
        self.dto = model
    }
}
