//
//  CartTableViewCellViewModel.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit

protocol CartCellViewModelDelegate {
    func showAlert(nftImage: UIImage, id: String)
}

final class CartTableViewCellViewModel {
    private(set) var imageURL: URL
    private(set) var nftName: String
    private(set) var rating: Int
    private(set) var price: Float
    private(set) var currency: String
    private(set) var priceString: String
    private let id: String
    var delegate: CartCellViewModelDelegate?
    
    init(imageURL: URL, nftName: String, rating: Int, price: Float, currency: String, id: String ) {
        self.imageURL = imageURL
        self.nftName = nftName
        self.rating = rating
        self.price = price
        self.currency = currency
        self.id = id
        let stringPrice = String(price).replacingOccurrences(of: ".", with: ",")
        self.priceString = stringPrice + " " + currency
    }
    
    func pressDelete(image:UIImage) {
        delegate?.showAlert(nftImage: image, id: id)
    }
}
