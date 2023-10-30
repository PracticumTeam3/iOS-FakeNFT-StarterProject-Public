//
//  GetNFTRequest.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 30.10.2023.
//

import Foundation
struct GetNFTRequest: NetworkRequest {
    let id: String
    var endpoint: URL? {
        Endpoint.nftById(id: self.id).url
    }
    var httpMethod: HttpMethod { .get }
    
    init (id:String) {
        self.id = id
    }
}
