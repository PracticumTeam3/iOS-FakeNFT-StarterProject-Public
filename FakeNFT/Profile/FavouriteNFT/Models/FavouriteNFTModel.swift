//
//  FavouriteNFTModel.swift
//  FakeNFT
//
//  Created by Artem Novikov on 18.10.2023.
//

import Foundation

// MARK: - FavouriteNFTModel
struct FavouriteNFTModel: Equatable {
    let id: String
    let image: String
    let name: String
    let rating: Int
    let price: Float

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.image == rhs.image &&
        lhs.name == rhs.name &&
        lhs.rating == rhs.rating &&
        lhs.price == rhs.price
    }
}
