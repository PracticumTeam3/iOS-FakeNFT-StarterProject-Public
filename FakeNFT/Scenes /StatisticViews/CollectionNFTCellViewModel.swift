//
//  CollectionNFTCellViewModel.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 03.11.2023.
//

import Foundation

protocol CollectionNFTCellViewModelDelegate: AnyObject {
    func reloadItems(indexPath: IndexPath)
    func showAlert()
}

protocol CollectionNFTCellViewModelProtocol {
    var name: String { get }
    var price: String { get }
    var rating: String { get }
    var images: [String] { get }
    var id: String { get }
    var profileLikes: [String] { get }
    var profileNfts : [String] { get }
    func fetchProfileNfts(completion: @escaping() -> Void)
    func fetchProfileLikes(completion: @escaping() -> Void)
    func putProfileNftBasket(nft: String, completion: @escaping() -> Void)
    func putProfileLikes(like: String, completion: @escaping() -> Void)
    func basketButtonTapped()
    func likeButtonTapped()
    
}

final class CollectionNFTCellViewModel: CollectionNFTCellViewModelProtocol {
    // MARK: - Public properties
    var name: String {
        nft.name
    }
    var price: String {
        String(nft.price)
    }
    var rating: String {
        String(nft.rating)
    }
    var images: [String] {
        nft.images
    }
    var id: String {
        nft.id
    }
    var profileLikes: [String] = []
    var profileNfts : [String] = []
    var indexPath: IndexPath?
    weak var delegate: CollectionNFTCellViewModelDelegate?
    
    // MARK: - Private properties
    private var nft: NFTResult
    
    // MARK: - Initializers
    init(nft: NFTResult, indexPath: IndexPath, delegate: CollectionNFTCellViewModelDelegate) {
        self.nft = nft
        self.indexPath = indexPath
        self.delegate = delegate
    }
    
    // MARK: - Public properties
    func likeButtonTapped() {
        putProfileLikes(like: id) { [weak self] in
            guard let self = self,
                  let indexPath = indexPath,
                  let delegate = delegate
            else { return }
            delegate.reloadItems(indexPath: indexPath)
        }
    }
    
    func basketButtonTapped() {
      putProfileNftBasket(nft: id) { [weak self] in
            guard let self = self,
                  let indexPath = indexPath,
                  let delegate = delegate
            else { return }
            delegate.reloadItems(indexPath: indexPath)
        }
    }
    
    func fetchProfileLikes(completion: @escaping() -> Void) {
        ProfileLikeService.shared.fetchProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                self.profileLikes = profile.likes
                completion()
            case .failure(_):
                delegate?.showAlert()
            }
        }
    }
    
    func fetchProfileNfts(completion: @escaping() -> Void) {
        ProfileNftService.shared.fetchProfile { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                self.profileNfts = profile.nfts
                completion()
            case .failure(_):
                delegate?.showAlert()
            }
        }
    }
    
    func putProfileNftBasket(nft: String, completion: @escaping() -> Void) {
        if profileNfts.contains(nft) {
            let filteredNfts = profileNfts.filter { $0 != nft }
            profileNfts = filteredNfts
        } else {
            profileNfts.append(nft)
        }
        let model = ProfileNftsModel(nfts: profileNfts)
        ProfileNftService.shared.putProfileNFT(model: model) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newProfileNfts):
                self.profileNfts = newProfileNfts.nfts
                completion()
            case .failure(_):
                delegate?.showAlert()
            }
        }
    }
    
    func putProfileLikes(like: String, completion: @escaping() -> Void) {
        if profileLikes.contains(like) {
            let filteredNfts = profileLikes.filter { $0 != like }
            profileLikes = filteredNfts
        } else {
            profileLikes.append(like)
        }
        let model = ProfileLikesModel(likes: profileLikes)
        ProfileLikeService.shared.putProfileLikes(model: model) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let newProfileLikes):
                self.profileLikes = newProfileLikes.likes
                completion()
            case .failure(_):
                delegate?.showAlert()
            }
        }
    }
}
