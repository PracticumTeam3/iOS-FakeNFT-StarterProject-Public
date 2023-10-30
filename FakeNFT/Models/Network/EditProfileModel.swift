//
//  EditProfileModel.swift
//  FakeNFT
//
//  Created by Artem Novikov on 10.10.2023.
//

import Foundation

struct EditProfileModel: Codable, Equatable {
    let avatar: String
    let name: String
    let description: String
    let website: String

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.avatar == rhs.avatar &&
        lhs.name == rhs.name &&
        lhs.description == rhs.description &&
        lhs.website == rhs.website
    }
}
