//
//  StorageService.swift
//  FakeNFT
//
//  Created by Artem Novikov on 09.10.2023.
//

import Foundation
import os.log

// MARK: - StorageServiceProtocol
protocol StorageServiceProtocol: AnyObject {
    var onProfileInfoChanged: (() -> Void)? { get set }
    var profile: ProfileModel? { get set }
    var sortType: SortType { get set }
    var wasOnboardingShown: Bool { get set }
}

// MARK: - StorageService
final class StorageService: StorageServiceProtocol {

    // MARK: - Public  properties
    static let shared = StorageService()
    var onProfileInfoChanged: (() -> Void)?

    var profile: ProfileModel? {
        get {
            guard let data = userDefaults.data(forKey: Keys.profile.rawValue),
                  let record = try? JSONDecoder().decode(ProfileModel.self, from: data) else {
                return nil
            }
            return record
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else {
                os_log("Невозможно сохранить результат", log: .default, type: .error)
                return
            }
            userDefaults.set(data, forKey: Keys.profile.rawValue)
            onProfileInfoChanged?()
        }
    }

    var sortType: SortType {
        get {
            guard
                let sortTypeString = userDefaults.string(forKey: Keys.sortType.rawValue),
                let sortType = SortType(rawValue: sortTypeString)
            else {
                return .byRating
            }
            return sortType
        }
        set {
            userDefaults.setValue(newValue.rawValue, forKey: Keys.sortType.rawValue)
        }
    }

    var environment: Environment {
        get {
            guard
                let environmentString = userDefaults.string(forKey: Keys.environment.rawValue),
                let environment = Environment(rawValue: environmentString)
            else {
                return .prod
            }
            return environment
        }
        set {
            userDefaults.setValue(newValue.rawValue, forKey: Keys.environment.rawValue)
        }
    }

    var wasOnboardingShown: Bool {
        get {
            userDefaults.bool(forKey: Keys.wasOnboardingShown.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.wasOnboardingShown.rawValue)
        }
    }

    // MARK: - Private  properties
    private enum Keys: String {
        case profile, sortType, wasOnboardingShown, environment
    }

    private let userDefaults = UserDefaults.standard

    // MARK: - Initializers
    private init() {}

}
