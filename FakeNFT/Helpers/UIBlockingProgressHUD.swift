//
//  UIBlockingProgressHUD.swift
//  FakeNFT
//
//  Created by Artem Novikov on 09.10.2023.
//

import UIKit
import ProgressHUD

// MARK: - UIBlockingProgressHUD
final class UIBlockingProgressHUD {

    private static var window: UIWindow? {
        UIApplication.shared.windows.first
    }

    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }

    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }

}
