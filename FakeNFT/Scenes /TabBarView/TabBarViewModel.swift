//
//  TabBarViewModel.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit

final class TabBarViewModel {
    private(set) var catalogeVC: UIViewController
    private(set) var cartVC: UIViewController
    private(set) var profileVC: UIViewController
    private(set) var statisticVC: UIViewController
    init() {
        self.catalogeVC = UIViewController()
        let vc = CartTableViewViewController(viewModel: CartTableViewViewModel())
        let navVC = UINavigationController(rootViewController: vc)
        self.cartVC = navVC
        self.profileVC = UIViewController()
        self.statisticVC = UIViewController()
    }
}
