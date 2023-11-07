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
    let cartService = CartService.shared
    
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

    var carts: [String] = [] {
        didSet {
            onChange?()
        }
    }

    func bindCart() {
        self.carts = cartService.nfts.map { $0.id }
        cartService.$nfts.bind { nfts in
            self.carts = nfts.map { $0.id }
        }
    }

    func getUsers(id: String) {
        service.getUsers(id: id) { result in
            switch result {
            case .success(let model):
                self.author = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func getNFT(id: String) {
        service.getNFT(id: id) { result in
            switch result {
            case .success(let model):
                self.NFT[id] = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    var lastNftRequestTime: DispatchTime = .now()

    func getNFTs(nfts:[String]) {
        lastNftRequestTime = .now()
        nfts.forEach { id in
            let newTime = lastNftRequestTime + 0.3
            lastNftRequestTime = newTime
            DispatchQueue.main.asyncAfter(deadline: lastNftRequestTime) {
                self.getNFT(id:id)
            }
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
            case .success:
                self.getFavouriteNFTs()
            case .failure:
                self.likes.removeAll { $0 == id}
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

    func setCart(id: String) {
        if carts.contains(where: { $0 == id }) {
            self.cartService.changeOrder(deleteNftId: id)
        } else {
            self.cartService.changeOrder(addNftId: id)
        }
    }
}
