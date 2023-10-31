//
//  UserDefaults.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 30.10.2023.
//

import Foundation

class Storage {
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
