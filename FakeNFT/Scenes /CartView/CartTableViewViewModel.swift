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
    private var nfts = mockNFT
    @CartObservable private(set) var sortedNFT = [CartTableViewCellViewModel]()
    @CartObservable private(set) var nftIsEmpty: Bool = false
    @CartObservable private(set) var nftCount: String = "10 NFT"
    @CartObservable private(set) var nftPrices: String = "5,34 ETH"
    private var sortedName: CartSortedStorage = .name
    var delegate: CartTableViewViewModelDelegateProtocol?
    init() {
        sortedNFT = nfts
        checkNFTCount()
    }
    
    private func checkNFTCount() {
        nftIsEmpty = sortedNFT.isEmpty
    }
    private func sortedCart() {
        switch sortedName {
        case .name:
            print("Сортировка по имени")
        case .price:
            print("Сортировка по цене")
        case .raiting:
            print("Сортировка по рейтингу")
        }
    }
    func changeSortes() {
    }
    
}
//MARK: - Extension CartTableViewCellViewModelDelegateProtocol
extension CartTableViewViewModel: CartTableViewCellViewModelDelegateProtocol {
    func showAlert(nftImage: UIImage, index: Int) {
        let alertVC = NftDeleteAlert(image: nftImage, index: index)
        alertVC.delegate = self
        alertVC.modalPresentationStyle = .overFullScreen
        delegate?.showVC(alertVC)
    }
}

//MARK: - Extension NfyDeleteAlertDelegateProtocol
extension CartTableViewViewModel: NfyDeleteAlertDelegateProtocol {
    func deleteNft(index: Int) {
        print("delete nft, index \(index)")
    }
}


//МОКОВЫЕ ЗНАЧЕНИЯ ДЛЯ НФТ
private let cartTableViewCellViewModel1 = CartTableViewCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png")!,
                                                             nftName: "First Test",
                                                             rating: 0,
                                                             price: "4 ETH")
private let cartTableViewCellViewModel2 = CartTableViewCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png")!,
                                                             nftName: "Second Test",
                                                             rating: 1,
                                                             price: "4 ETH")
private let cartTableViewCellViewModel3 = CartTableViewCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png")!,
                                                             nftName: "ThirdTest",
                                                             rating: 4,
                                                             price: "10 ETH")
private let cartTableViewCellViewModel4 = CartTableViewCellViewModel(imageURL: URL(string: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png")!,
                                                             nftName: "FourTest",
                                                             rating: 5,
                                                             price: "10 ETH")

let mockNFT = [cartTableViewCellViewModel1, cartTableViewCellViewModel2,cartTableViewCellViewModel3,cartTableViewCellViewModel4]
