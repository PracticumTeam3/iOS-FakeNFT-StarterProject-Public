//
//  UserSortedServise.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 12.10.2023.
//

import Foundation

final class UserSortedService {
    private let userDefaults = UserDefaults.standard
    //сортировка корзины
    var cartSorted: CartSortedStorage {
        get {
            guard let data = userDefaults.data(forKey: Keys.cartSorted.rawValue),
                  let sorted = try? JSONDecoder().decode(CartSortedStorage.self, from: data) else {
                return CartSortedStorage.name
            }
            return sorted
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить сортировку корзины")
                return
            }
            userDefaults.set(data, forKey: Keys.cartSorted.rawValue)
        }
    }
    private enum Keys: String, CodingKey {
        case cartSorted
    }
}
