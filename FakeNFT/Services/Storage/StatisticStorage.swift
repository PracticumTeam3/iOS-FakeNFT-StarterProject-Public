//
//  StatisticStorage.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 30.10.2023.
//

import Foundation

final class StatisticStorage {
   static var isSortByName: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isSortByKey")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isSortByKey")
        }
    }

    private init() {}
}
