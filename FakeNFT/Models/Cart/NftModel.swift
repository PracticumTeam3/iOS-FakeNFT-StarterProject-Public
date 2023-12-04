//
//  NftModel.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 25.10.2023.
//

import Foundation

struct NftModel {
    var name: String
    var imagesURL: [URL?]
    var rating: Int
    var price: Float
    var id: String

    init(name: String, images: [String], rating: Int, price: Float, id: String) {
        self.name = name
        if images.isEmpty {
            self.imagesURL = [nil]
        } else {
            self.imagesURL = images.compactMap({ URL(string: $0) })
        }
        self.rating = rating
        self.price = price
        self.id = id
    }
}
