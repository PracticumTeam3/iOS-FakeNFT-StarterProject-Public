//
//  GetProfilesRequest.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 24.10.2023.
//

import Foundation

struct GetProfilesRequest: NetworkRequest {
    var endpoint: URL? {
        let baseUrl = Request().endpoint
        return URL(string: "/api/v1/users", relativeTo: baseUrl)
    }
}
