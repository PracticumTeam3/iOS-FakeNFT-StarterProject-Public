//
//  CartTableViewViewModel.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit

protocol CartTableViewViewModelDelegate: AnyObject {
    func showVC(_ vc: UIViewController)
}

final class CartTableViewViewModel {
    
    private var nfts = [CartTableViewCellViewModel]()
    
    private enum ConstantName {
        static let nft = "NFT"
        static let eth = "ETH"
    }
    
    @CartObservable private(set) var sortedNFT = [CartTableViewCellViewModel]()
    @CartObservable private(set) var nftIsEmpty: Bool = true
    @CartObservable private(set) var nftCount: String = ""
    @CartObservable private(set) var nftPrices: String = ""
    @CartObservable private(set) var progressHUDIsActive: Bool = true
    
    private let userSortedService = UserSortedService()
    private let cartService = CartService.shared
    private var sortedName: CartSortedStorage?
    weak var delegate: CartTableViewViewModelDelegate?
    
    init() {
        progressHUDIsActive = true
        sortedName = userSortedService.cartSorted
        fetchOrder()
        sortedCart()
        countNft()
        checkOverPrice()
        bind()
    }
    
    private func fetchOrder() {
        cartService.fetchOrder()
        self.nfts = self.cartService.nfts.compactMap { CartTableViewCellViewModel(imageURL: $0.imagesURL[0],
                                                                                  nftName: $0.name,
                                                                                  rating: $0.rating,
                                                                                  price: $0.price,
                                                                                  currency: ConstantName.eth,
                                                                                  id: $0.id)}
    }
    
    private func checkNFTCount() {
        nftIsEmpty = nfts.isEmpty
    }
    
    private func sortedCart() {
        guard let sortedName = sortedName else { return }
        if nftIsEmpty { return }
        switch sortedName {
        case .name:
            sortedNFT = nfts.sorted {$0.nftName < $1.nftName}
        case .price:
            sortedNFT = nfts.sorted {$0.price > $1.price}
        case .rating:
            sortedNFT = nfts.sorted {$0.rating > $1.rating}
        }
    }
    
    func changeSortes(_ newParametr: CartSortedStorage) {
        userSortedService.cartSorted = newParametr
        sortedName = userSortedService.cartSorted
        sortedCart()
    }
    
    private func bind() {
        cartService.$nfts.bind { [weak self] newNftModel in
            self?.nfts = newNftModel.compactMap { CartTableViewCellViewModel(imageURL: $0.imagesURL[0],
                                                                             nftName: $0.name,
                                                                             rating: $0.rating,
                                                                             price: $0.price,
                                                                             currency: ConstantName.eth,
                                                                             id: $0.id)}
            self?.checkNFTCount()
            self?.sortedCart()
            self?.countNft()
            self?.checkOverPrice()
            self?.progressHUDIsActive = false
        }
    }
    
    private func countNft() {
        nftCount = String(nfts.count) + " " + ConstantName.nft
    }
    
    private func checkOverPrice() {
        let price = nfts.reduce(0) {$0 + $1.price}
        nftPrices = price.nftPriceString(price: ConstantName.eth)
    }
    
}
// MARK: - Extension CartCellViewModelDelegate
extension CartTableViewViewModel: CartCellViewModelDelegate {
    func showAlert(nftImage: UIImage, id: String) {
        let alertVC = NftDeleteAlert(image: nftImage, id: id)
        alertVC.delegate = self
        alertVC.modalPresentationStyle = .overFullScreen
        delegate?.showVC(alertVC)
    }
}

// MARK: - Extension NfyDeleteAlertDelegate
extension CartTableViewViewModel: NfyDeleteAlertDelegate {
    func deleteNft(id: String) {
        cartService.changeOrder(deleteNftId: id)
    }
}

// Mock data NFT
/*
private let mockURL = URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png")!
private let cartTableViewCellViewModel1 = CartTableViewCellViewModel(imageURL: mockURL,
                                                                     nftName: "First Test",
                                                                     rating: 0,
                                                                     price: 2.32,
                                                                     currency: "ETH")
private let cartTableViewCellViewModel2 = CartTableViewCellViewModel(imageURL: mockURL,
                                                                     nftName: "Second Test",
                                                                     rating: 1,
                                                                     price: 1.12,
                                                                     currency: "ETH")
private let cartTableViewCellViewModel3 = CartTableViewCellViewModel(imageURL: mockURL,
                                                                     nftName: "ThirdTest",
                                                                     rating: 5,
                                                                     price: 1.17,
                                                                     currency: "ETH")
private let cartTableViewCellViewModel4 = CartTableViewCellViewModel(imageURL: mockURL,
                                                                     nftName: "FourTest",
                                                                     rating: 3,
                                                                     price: 0.03,
                                                                     currency: "ETH")

let mockNFT = [cartTableViewCellViewModel1,
               cartTableViewCellViewModel2,
               cartTableViewCellViewModel3,
               cartTableViewCellViewModel4]
*/
