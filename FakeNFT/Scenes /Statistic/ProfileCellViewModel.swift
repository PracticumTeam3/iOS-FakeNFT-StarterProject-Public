//
//  ProfileCellViewModel.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 24.10.2023.
//

import Foundation

protocol ProfileCellViewModelProtocol {
    var profileName: String { get }
    var rating: String { get }
    var numberUser: String { get }
    var profileImage: String { get }
    var infoUser: String { get }
    var websiteUrl: String { get }
    var nfts: [String] { get }
    var id: String { get }
    init(profile: UserNetworkModel, indexPath: IndexPath)
}

struct ProfileCellViewModel: ProfileCellViewModelProtocol {
    // MARK: - Public properties
    var numberUser: String
    var rating: String {
        profile.rating
    }
    var profileImage: String {
        profile.avatar
    }
    var profileName: String {
        profile.name
    }
    var infoUser: String {
        profile.description
    }
    var websiteUrl: String {
        profile.website
    }
    var nfts: [String] {
        profile.nfts
    }
    var id: String {
        profile.id
    }

    // MARK: - Private properties
    private let profile: UserNetworkModel

    // MARK: - init
    init(profile: UserNetworkModel, indexPath: IndexPath) {
        self.profile = profile
        numberUser = String(indexPath.row + 1)
    }
}
