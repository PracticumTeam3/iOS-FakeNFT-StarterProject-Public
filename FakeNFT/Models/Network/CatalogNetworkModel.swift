//
//  CatalogNetworkModel.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 01.11.2023.
//

import Foundation

struct CatalogNetworkModel: Codable {
    let createdAt:String
    let name: String
    let cover: String
    let nfts: [String]
    let description: String
    let author: String
    let id: String

}

