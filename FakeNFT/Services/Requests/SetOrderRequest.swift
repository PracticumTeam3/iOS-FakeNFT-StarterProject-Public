//
//  SetOrderRequest.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 30.10.2023.
//

import Foundation

struct SetOrderRequest: NetworkRequest {
    let model: OrderNetwork
    var endpoint: URL? {
        Endpoint.order.url
    }
    var httpMethod: HttpMethod { .put }
    var dto: Encodable? {
        model
    }
    init(model:OrderNetwork) {
        self.model = model
    }

}
