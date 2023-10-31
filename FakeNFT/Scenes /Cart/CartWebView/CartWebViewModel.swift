//
//  CartWebViewModel.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 31.10.2023.
//

import Foundation

final class CartWebViewModel {
    @CartObservable private(set) var progressHUDIsActive: Bool = true
    @CartObservable private(set) var progress: Double = 0.0
    @CartObservable private(set) var progressIsHidden: Bool = false
    private let webURLString = "https://yandex.ru/legal/practicum_termsofuse/"
    
    func didUpdateProgressValue(_ newValue: Double) {
        progress = newValue
        if newValue == 1.0 {
            progressHUDIsActive = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.progressIsHidden = true
            }
        }
    }
    
    func getRequest() -> URLRequest? {
        guard let url = URL(string: "https://yandex.ru/legal/practicum_termsofuse/") else { return nil }
        return URLRequest(url: url)
    }   
}
