//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 28.10.2023.
//

import Foundation

final class CollectionViewModel {
    let service = CollectionService(networkClient: DefaultNetworkClient())
    let profileService = ProfileService(networkClient: DefaultNetworkClient())
    var onChange: (() -> Void)?
    var author: AutorModel? {
        didSet {
            onChange?()
        }
    }

    var NFT: [String:NFTCollectionModel] = [:] {
        didSet {
            onChange?()
        }
    }

   var likes: [String] = [] {
        didSet {
            onChange?()
        }
    }

    func getUsers (id: String) {
        service.getUsers(id: id) { result in
            switch result {
            case .success(let model):
                self.author = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getNFT (id: String) {
        service.getNFT(id: id) { result in
            switch result {
            case .success(let model):
                self.NFT[id] = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getNFTs (nfts:[String]) {
        nfts.forEach { id in
            getNFT(id:id)
        }
    }

    func setLikes(id: String) {
        if likes.contains(where: { $0 == id}) {
            likes.removeAll { $0 == id}
        } else {
            likes.append(id)
        }
        let likeModel = LikesModel(likes: likes)
        profileService.setLikes(likeModel) { result in
            switch result {
            case .success(_):
                self.getFavouriteNFTs()
            case .failure(_):
                self.likes.removeAll{ $0 == id}
            }
        }
    }

    func getFavouriteNFTs() {
        profileService.getFavouriteNFTs { result in
            switch result {
            case .success(let likes):
                self.likes = likes.map { $0.id }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
