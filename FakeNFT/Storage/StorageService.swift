//
//  StorageService.swift
//  FakeNFT
//
//  Created by Artem Novikov on 06.11.2023.
//

import Foundation

// MARK: - StorageServiceProtocol
protocol StorageServiceProtocol: AnyObject {
    var environment: Environment { get set }
    var wasOnboardingShown: Bool { get set }
}

// MARK: - StorageService
final class StorageService: StorageServiceProtocol {

    // MARK: - Public  properties
    static let shared = StorageService()

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
        case wasOnboardingShown, environment
    }

    private let userDefaults = UserDefaults.standard

    // MARK: - Initializers
    private init() {}

}
