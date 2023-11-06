//
//  GetCurrencyRequest.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 30.10.2023.
//

import Foundation

struct GetCurrencyRequest: NetworkRequest {
    var endpoint: URL? { Endpoint.currencies.url }
    var httpMethod: HttpMethod { .get }
}
