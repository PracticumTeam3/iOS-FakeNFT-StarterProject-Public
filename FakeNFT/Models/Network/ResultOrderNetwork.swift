//
//  ResultOrderNetwork.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 26.10.2023.
//

import Foundation

struct ResultOrderNetwork: Codable {
    let success: Bool
    let orderId: String
    let currencyId: String

    enum CodingKeys: String, CodingKey {
        case success
        case orderId
        case currencyId = "id"
    }
}
