//
//  CartTableViewViewModel.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit
protocol CartTableViewViewModelDelegateProtocol {
    func showVC(_ vc: UIViewController)
}

final class CartTableViewViewModel {
    
    private let nfts = mockNFT
    
    @CartObservable private(set) var sortedNFT = [CartTableViewCellViewModel]()
    @CartObservable private(set) var nftIsEmpty: Bool = true
    @CartObservable private(set) var nftCount: String = "10 NFT"
    @CartObservable private(set) var nftPrices: String = "5,34 ETH"
    
    private let userSortedService = UserSortedService()
    private var sortedName: CartSortedStorage?
    var delegate: CartTableViewViewModelDelegateProtocol?
    
    init() {
        sortedName = userSortedService.cartSorted
        checkNFTCount()
        sortedCart()
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
}
// MARK: - Extension CartCellViewModelDelegateProtocol
extension CartTableViewViewModel: CartCellViewModelDelegateProtocol {
    func showAlert(nftImage: UIImage, index: Int) {
        let alertVC = NftDeleteAlert(image: nftImage, index: index)
        alertVC.delegate = self
        alertVC.modalPresentationStyle = .overFullScreen
        delegate?.showVC(alertVC)
    }
}

// MARK: - Extension NfyDeleteAlertDelegateProtocol
extension CartTableViewViewModel: NfyDeleteAlertDelegateProtocol {
    func deleteNft(index: Int) {
        print("delete nft, index \(index)")
        checkNFTCount()
    }
}

// МОКОВЫЕ ЗНАЧЕНИЯ ДЛЯ НФТ
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
