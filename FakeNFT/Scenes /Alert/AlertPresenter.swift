//
//  AlertPresenter.swift
//  FakeNFT
//
//  Created by Artem Novikov on 10.10.2023.
//

import UIKit

// MARK: - AlertPresenter
final class AlertPresenter {

    static func show(in controller: UIViewController, model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: model.preferredStyle
        )
        alert.view.accessibilityIdentifier = AccessibilityIdentifier.Alert.view
        for button in model.buttons {
            let action = UIAlertAction(title: button.text, style: button.style) { _ in
                button.completion(())
            }
            alert.addAction(action)
            if button.isPreferredAction {
                alert.preferredAction = action
            }
        }
        if controller.presentedViewController == nil {
            controller.present(alert, animated: true, completion: nil)
        }
    }

    static func show(in controller: UIViewController, model: AlertWithTextFieldModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert
        )
        alert.view.accessibilityIdentifier = AccessibilityIdentifier.Alert.view
        alert.addTextField { (textField) in
            textField.placeholder = model.textField.placeholder
        }

        let okAction = UIAlertAction(
            title: model.okButton.text,
            style: model.okButton.style
        ) { _ in
            model.okButton.completion(alert.textFields?.first?.text)
        }
        alert.addAction(okAction)

        let cancelAction = UIAlertAction(
            title: model.cancelButton.text,
            style: model.cancelButton.style
        ) { _ in
            model.cancelButton.completion(())
        }
        alert.addAction(cancelAction)

        if controller.presentedViewController == nil {
            controller.present(alert, animated: true, completion: nil)
        }
    }

}
