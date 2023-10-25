//
//  NFTResult.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 25.10.2023.
//

import Foundation

struct NFTResult: Codable {
    var name: String
    var images: [String]
    var rating: Int
    var price: Float
    var id: String
}
