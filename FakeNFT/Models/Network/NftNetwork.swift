//
//  NftNetwork.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 25.10.2023.
//

import Foundation

struct NftNetwork: Codable {
    let name: String
    let images: [String]
    let rating: Int
    let price: Float
    let id: String
}
