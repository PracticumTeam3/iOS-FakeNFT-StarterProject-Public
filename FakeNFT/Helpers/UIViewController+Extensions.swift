//
//  UIViewController+Extensions.swift
//  FakeNFT
//
//  Created by Artem Novikov on 09.10.2023.
//

import UIKit

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
