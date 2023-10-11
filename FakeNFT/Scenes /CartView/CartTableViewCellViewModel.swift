//
//  CartTableViewCellViewModel.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import Foundation

final class CartTableViewCellViewModel {
    private(set) var imageURL: URL
    private(set) var nftName: String
    private(set) var rating: Int
    private(set) var price: String
    init(imageURL: URL, nftName: String, rating: Int, price: String) {
        self.imageURL = imageURL
        self.nftName = nftName
        self.rating = rating
        self.price = price
    }
}
