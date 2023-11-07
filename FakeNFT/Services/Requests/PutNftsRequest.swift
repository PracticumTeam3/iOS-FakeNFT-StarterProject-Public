//
//  PutNftsRequest.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 06.11.2023.
//

import Foundation

struct PutNftsRequest: NetworkRequest {
    var endpoint: URL? {
        let baseUrl = Request().endpoint
        return URL(string: "/api/v1/profile/1", relativeTo: baseUrl)
    }
    var httpMethod: HttpMethod = .put
    var dto: Encodable?
        
    init(model: ProfileNftsModel) {
        self.dto = model
    }
}
