//
//  UserDefaults.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 30.10.2023.
//

import Foundation

class StorageService {
   static var sortProfiles: Bool {
        get {
            UserDefaults.standard.bool(forKey: "key")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "key")
        }
    }
    
    private init() {}
}
