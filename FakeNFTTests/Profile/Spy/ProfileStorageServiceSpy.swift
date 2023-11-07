//
//  ProfileStorageServiceSpy.swift
//  FakeNFTTests
//
//  Created by Artem Novikov on 01.11.2023.
//

@testable import FakeNFT

// MARK: - ProfileStorageServiceSpy
final class ProfileStorageServiceSpy: ProfileStorageServiceProtocol {

    var onProfileInfoChanged: (() -> Void)?

    var profile: ProfileModel? = ProfileModel(
        name: "Name Surname",
        avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
        description: "Description",
        website: "https://practicum.yandex.ru/profile/ios-developer/",
        nfts: ["1", "2"],
        likes: ["4"]
    )
    var sortType: SortType = .byName

}
