//
//  GetResultOrderRequest.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 30.10.2023.
//

import Foundation

struct GetResultOrderRequest: NetworkRequest {
    let id: String
    var endpoint: URL? { Endpoint.paymentById(id: self.id).url }
    var httpMethod: HttpMethod { .get }

    init(id: String) {
        self.id = id
    }
}
