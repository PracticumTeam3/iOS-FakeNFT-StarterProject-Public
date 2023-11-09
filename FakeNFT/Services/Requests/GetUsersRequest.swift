//
//  GetProfilesRequest.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 24.10.2023.
//

import Foundation

struct GetUsersRequest: NetworkRequest {
    var endpoint: URL? {
        Endpoint.users.url
    }
}
