//
//  Storage.swift
//  FakeNFT
//
//  Created by Artem Novikov on 09.10.2023.
//

import Foundation

extension UserDefaults {

    private enum Keys: String {
        case profile, profileLastChangeTime, sortType
    }

    @objc dynamic var profileLastChangeTime: Int {
        get {
            integer(forKey: Keys.profileLastChangeTime.rawValue)
        }
        set {
            setValue(newValue, forKey: Keys.profileLastChangeTime.rawValue)
        }
    }

    var profile: ProfileModel? {
        get {
            guard let data = data(forKey: Keys.profile.rawValue),
                  let record = try? JSONDecoder().decode(ProfileModel.self, from: data) else {
                return nil
            }
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            set(data, forKey: Keys.profile.rawValue)
        }
    }

    @objc dynamic var sortType: SortType {
        get {
            guard let data = data(forKey: Keys.sortType.rawValue),
                  let record = try? JSONDecoder().decode(SortType.self, from: data) else {
                return .byRating
            }
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            set(data, forKey: Keys.sortType.rawValue)
        }
    }

}
