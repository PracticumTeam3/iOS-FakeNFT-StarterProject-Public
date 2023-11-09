//
//  AppUtility.swift
//  FakeNFT
//
//  Created by Artem Novikov on 25.10.2023.
//

import UIKit

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

}
