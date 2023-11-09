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
    let buttons: [AlertButton<Void>]
    let preferredStyle: UIAlertController.Style

    static var urlParsingError: AlertModel {
        AlertModel(
            title: L.Profile.Alert.urlError,
            message: nil,
            buttons: [
                AlertButton(
                    text: L.Alert.ok,
                    style: .default,
                    completion: {}
                )
            ],
            preferredStyle: .alert
        )
    }

    static func confirmChanging(
        agreeCompletion: @escaping () -> Void,
        cancelCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Profile.Alert.saveChanges,
            message: nil,
            buttons: [
                AlertButton(
                    text: L.Alert.yes,
                    style: .default,
                    completion: agreeCompletion
                ),
                AlertButton(
                    text: L.Alert.no,
                    style: .destructive,
                    completion: cancelCompletion
                )
            ],
            preferredStyle: .alert
        )
    }

    static func profileFetchError(
        message: String,
        tryAgainCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Profile.Alert.fetchError,
            message: message,
            buttons: [
                AlertButton(
                    text: L.Alert.tryAgain,
                    style: .default,
                    completion: tryAgainCompletion
                )
            ],
            preferredStyle: .alert
        )
    }

    static func cartNetworkError(
        repeatCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Cart.networkAlertTitle,
            message: L.Cart.networkAlertMessage,
            buttons: [
                AlertButton(
                    text:  L.Alert.cancel,
                    style: .default,
                    completion: {}
                ),
                AlertButton(
                    text:  L.Alert.repeat,
                    style: .default,
                    completion: repeatCompletion
                )
            ],
            preferredStyle: .alert
        )
    }

    static func cartPaymentError(
        repeatCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Cart.failurePay,
            message: nil,
            buttons: [
                AlertButton(
                    text:  L.Alert.cancel,
                    style: .default,
                    completion: {}
                ),
                AlertButton(
                    text:  L.Alert.repeat,
                    style: .default,
                    completion: repeatCompletion,
                    isPreferredAction: true
                )
            ],
            preferredStyle: .alert
        )
    }

    static func myNFTLoadError(message: String) -> AlertModel {
        baseLoadError(
            title: L.Profile.MyNFT.Alert.fetchError,
            message: message
        )
    }

    static func favouriteNFTLoadError(message: String) -> AlertModel {
        baseLoadError(
            title: L.Profile.FavouriteNFT.Alert.fetchError,
            message: message
        )
    }

    static func unlikeError(message: String) -> AlertModel {
        baseLoadError(
            title: L.Profile.FavouriteNFT.Alert.unlikeError,
            message: message
        )
    }

    static func profileEditError(
        message: String,
        okCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Profile.Alert.editError,
            message: message,
            buttons: [
                AlertButton(
                    text: L.Alert.ok,
                    style: .default,
                    completion: okCompletion
                )
            ],
            preferredStyle: .alert
        )
    }

    static func sortActionSheet(
        priceCompletion: @escaping () -> Void,
        ratingCompletion: @escaping () -> Void,
        nameCompletion: @escaping () -> Void
    ) -> AlertModel {
        AlertModel(
            title: L.Alert.Sort.title,
            message: nil,
            buttons: [
                AlertButton(
                    text: L.Alert.Sort.price,
                    style: .default,
                    completion: priceCompletion
                ),
                AlertButton(
                    text: L.Alert.Sort.rating,
                    style: .default,
                    completion: ratingCompletion
                ),
                AlertButton(
                    text: L.Alert.Sort.name,
                    style: .default,
                    completion: nameCompletion
                ),
                AlertButton(
                    text: L.Alert.close,
                    style: .cancel,
                    completion: {}
                )
            ],
            preferredStyle: .actionSheet
        )
    }

    private static func baseLoadError(title: String, message: String) -> AlertModel {
        AlertModel(
            title: title,
            message: message,
            buttons: [
                AlertButton(
                    text: L.Alert.ok,
                    style: .default,
                    completion: {}
                )
            ],
            preferredStyle: .alert
        )
    }

}
