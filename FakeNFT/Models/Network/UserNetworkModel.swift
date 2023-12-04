//
//  UserNetworkModel.swift
//  FakeNFT
//
//  Created by Artem Novikov on 12.10.2023.
//

import Foundation

struct UserNetworkModel: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating: String
    let id: String
}
