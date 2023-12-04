//
//  GetOrderRequest.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 30.10.2023.
//

import Foundation

struct GetOrderRequest: NetworkRequest {
    var endpoint: URL? { Endpoint.order.url }
    var httpMethod: HttpMethod { .get }
}
