//
//  CartAlertPresenter.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 01.11.2023.
//

import UIKit

final class CartAlertPresenter {
    
    private var defaultNetWorkAlert = AlertModel(title: L.Cart.networkAlertTitle,
                                                 message: L.Cart.networkAlertMessage,
                                                 buttonTitle: L.Cart.cancel,
                                                 buttonTitle2: L.Cart.repeat)
    
    func showNetWorkAlert(viewController: UIViewController, completion: @escaping() -> Void) {
        let alert = UIAlertController(title: defaultNetWorkAlert.title,
                                      message: defaultNetWorkAlert.message,
                                      preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: defaultNetWorkAlert.buttonTitle, style: .default)
        let actionRepeat = UIAlertAction(title: defaultNetWorkAlert.buttonTitle2, style: .default) { _ in
            completion()
        }
        alert.addAction(actionCancel)
        alert.addAction(actionRepeat)
        viewController.present(alert, animated: true)
    }
    
}
