//
//  PaymentCellViewModel.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 18.10.2023.
//

import Foundation

final class PaymentCellViewModel {
    
    private(set) var imageURL: URL
    private(set) var coinName: String
    private(set) var coinShortName: String
    
    init(imageURL: URL, coinName: String, coinShortName: String) {
        self.imageURL = imageURL
        self.coinName = coinName
        self.coinShortName = coinShortName
    }
}
