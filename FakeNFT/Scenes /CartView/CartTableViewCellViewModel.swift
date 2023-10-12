//
//  CartTableViewCellViewModel.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit
import Kingfisher

protocol CartTableViewCellViewModelDelegateProtocol {
    func showAlert(nftImage: UIImage, index: Int)
}

final class CartTableViewCellViewModel {
    private(set) var imageURL: URL
    private(set) var nftName: String
    private(set) var rating: Int
    private(set) var price: String
    var delegate: CartTableViewCellViewModelDelegateProtocol?
    init(imageURL: URL, nftName: String, rating: Int, price: String) {
        self.imageURL = imageURL
        self.nftName = nftName
        self.rating = rating
        self.price = price
    }
    func pressDelete(image:UIImage, index: Int){
        delegate?.showAlert(nftImage: image, index: index)
    }
}
