//
//  ProfileNavigationController.swift
//  FakeNFT
//
//  Created by Artem Novikov on 11.10.2023.
//

import UIKit

// MARK: - ProfileNavigationController
final class ProfileNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

}

// MARK: - UIGestureRecognizerDelegate
extension ProfileNavigationController: UIGestureRecognizerDelegate {

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

}
