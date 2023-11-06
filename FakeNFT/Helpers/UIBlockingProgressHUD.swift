//
//  UIBlockingProgressHUD.swift
//  FakeNFT
//
<<<<<<< HEAD
//  Created by Artem Novikov on 09.10.2023.
//

import UIKit
import ProgressHUD

// MARK: - UIBlockingProgressHUD
final class UIBlockingProgressHUD {

    private static var window: UIWindow? {
        UIApplication.shared.windows.first
    }

=======
//  Created by Александр Кудряшов on 26.10.2023.
//

import Foundation

import UIKit
import ProgressHUD

final class UIBlockingProgressHUD {
    
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    
>>>>>>> kudryashov/epic_cart
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }
<<<<<<< HEAD

=======
    
>>>>>>> kudryashov/epic_cart
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
<<<<<<< HEAD

=======
>>>>>>> kudryashov/epic_cart
}
