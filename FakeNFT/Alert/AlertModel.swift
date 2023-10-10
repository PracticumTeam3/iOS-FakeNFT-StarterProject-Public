//
//  AlertModel.swift
//  FakeNFT
//
//  Created by Artem Novikov on 10.10.2023.
//

import UIKit

// MARK: - AlertModel
struct AlertModel {

    let title: String
    let message: String?
    let primaryButton: AlertButton?
    let secondaryButton: AlertButton?
    let preferredStyle: UIAlertController.Style

    static var urlParsingError: AlertModel {
        AlertModel(
            title: L.Profile.Alert.urlError,
            message: nil,
            primaryButton: AlertButton(
                text: L.Alert.ok,
                style: .default,
                completion: {}
            ),
            secondaryButton: nil,
            preferredStyle: .alert
        )
    }

    static func confirmChanging(yes: @escaping () -> Void, no: @escaping () -> Void) -> AlertModel {
        AlertModel(
            title: L.Profile.Alert.saveChanges,
            message: nil,
            primaryButton: AlertButton(
                text: L.Alert.yes,
                style: .default,
                completion: yes
            ),
            secondaryButton: AlertButton(
                text: L.Alert.no,
                style: .destructive,
                completion: no
            ),
            preferredStyle: .alert
        )
    }

    static func profileFetchError(
        message: String,
        primaryButtonCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Profile.Alert.fetchError,
            message: message,
            primaryButton: AlertButton(
                text: L.Alert.tryAgain,
                style: .default,
                completion: primaryButtonCompletion
            ),
            secondaryButton: nil,
            preferredStyle: .alert
        )
    }

    static func profileEditError(
        message: String,
        primaryButtonCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Profile.Alert.editError,
            message: message,
            primaryButton: AlertButton(
                text: L.Alert.ok,
                style: .default,
                completion: primaryButtonCompletion
            ),
            secondaryButton: nil,
            preferredStyle: .alert
        )
    }

}
