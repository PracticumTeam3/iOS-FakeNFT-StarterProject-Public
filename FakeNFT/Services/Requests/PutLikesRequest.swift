//
//  PutLikesRequest.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 05.11.2023.
//

import Foundation

struct PutLikesRequest: NetworkRequest {
    var endpoint: URL? {
        let baseUrl = Request().endpoint
        return URL(string: "/api/v1/profile/1", relativeTo: baseUrl)
    }
    var httpMethod: HttpMethod = .put
    var dto: Encodable?
        
    init(model: ProfileLikesModel) {
        self.dto = model
    }
}
