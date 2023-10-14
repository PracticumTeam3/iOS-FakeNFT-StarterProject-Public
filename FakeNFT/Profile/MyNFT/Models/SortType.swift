//
//  SortType.swift
//  FakeNFT
//
//  Created by Artem Novikov on 12.10.2023.
//

import Foundation

// MARK: - SortType
@objc enum SortType: Int, Codable {
    case byPrice
    case byRating
    case byName
}
