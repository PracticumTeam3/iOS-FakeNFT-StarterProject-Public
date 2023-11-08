//
//  GetNFTByID.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 02.11.2023.
//

import Foundation

struct GetNFTByIDRequest: NetworkRequest {
    let id: String
    var endpoint: URL? {
        let baseUrl = Request().endpoint
        return URL(string: "/api/v1/nft/\(id)", relativeTo: baseUrl)
    }
}
