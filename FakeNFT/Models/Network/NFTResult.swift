//
//  NFTResult.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 08.11.2023.
//

import Foundation

struct NFTResult: Codable {
    let name: String
    let rating: Int
    let price: Double
    let images: [String]
    let id: String
}
