//
//  CurrencyFormatter.swift
//  FakeNFT
//
//  Created by Artem Novikov on 02.11.2023.
//

import Foundation

final class CurrencyFormatter: NumberFormatter {

    override init() {
        super.init()
        numberStyle = .currency
        maximumFractionDigits = 3
        currencyCode = "ETH"
        locale = .current
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
