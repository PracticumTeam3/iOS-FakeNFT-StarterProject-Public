//
//  Foundation_ext.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 30.10.2023.
//

import Foundation

extension Float {
    func nftPriceString(price: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.decimalSeparator = ","
        numberFormatter.maximumFractionDigits = 2
        let numberString = numberFormatter.string(for: self) ?? String(self)
        return numberString + " " + price
    }
}
