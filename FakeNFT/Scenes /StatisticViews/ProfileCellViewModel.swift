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
    init(profile: ProfileResult, indexPath: IndexPath)
}

final class ProfileCellViewModel: ProfileCellViewModelProtocol {
    
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
    
    // MARK: - Private properties
    private let profile: ProfileResult
    
    // MARK: - init
    required init(profile: ProfileResult, indexPath: IndexPath) {
        self.profile = profile
        numberUser = String(indexPath.row + 1)
    }
}
