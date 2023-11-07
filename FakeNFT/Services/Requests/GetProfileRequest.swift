//
//  GetProfileRequest.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 04.11.2023.
//

import Foundation

struct GetProfileRequest: NetworkRequest {
    var endpoint: URL? {
        let baseUrl = Request().endpoint
        return URL(string: "/api/v1/profile/1", relativeTo: baseUrl)
    }
}
