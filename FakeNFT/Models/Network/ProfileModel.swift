//
//  ProfileModel.swift
//  FakeNFT
//
//  Created by Artem Novikov on 05.10.2023.
//

import UIKit

struct ProfileModel: Codable, Equatable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.name == rhs.name &&
        lhs.avatar == rhs.avatar &&
        lhs.description == rhs.description &&
        lhs.website == rhs.website &&
        Set(lhs.nfts) == Set(rhs.nfts) &&
        Set(lhs.likes) == Set(rhs.likes)
    }

}
