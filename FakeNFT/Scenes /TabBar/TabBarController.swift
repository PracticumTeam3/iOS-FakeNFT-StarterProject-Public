//
//  TabBarController.swift
//  FakeNFT
//
//  Created by Artem Novikov on 05.10.2023.
//

import UIKit

// MARK: - TabBarController
final class TabBarController: UITabBarController {

    // MARK: - Private Properties
    private var catalogNavigationController: UINavigationController {
        let vc = CatalogViewController()
        let navVC = UINavigationController(rootViewController: vc)

        navVC.tabBarItem = UITabBarItem(
            title: L.Catalog.title,
            image: A.Icons.TabBar.catalog.image,
            selectedImage: nil
        )

        return navVC
    }

    private var cartNavigationController: UINavigationController {
        let cartVM = CartTableViewViewModel()
        let vc = CartTableViewViewController(viewModel: cartVM)
        let navVC = UINavigationController(rootViewController: vc)

        navVC.tabBarItem = UITabBarItem(
            title: L.Cart.title,
            image: A.Icons.TabBar.cart.image,
            selectedImage: nil
        )

        return navVC
    }

    private var profileNavigationController: UINavigationController {
        let navigationController = ProfileNavigationController()
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)

        navigationController.viewControllers = [viewController]

        navigationController.tabBarItem = UITabBarItem(
            title: L.Profile.title,
            image: A.Icons.TabBar.profile.image,
            selectedImage: nil
        )
        navigationController.tabBarItem.accessibilityIdentifier = AccessibilityIdentifier.TabBar.profile
        return navigationController
    }

    private var statisticNavigationController: UINavigationController {
        let vc = ProfileListViewController()
        let navVC = UINavigationController(rootViewController: vc)

        navVC.tabBarItem = UITabBarItem(
            title: L.Statistics.title,
            image: A.Icons.TabBar.statistic.image,
            selectedImage: nil
        )

        return navVC
    }

    // MARK: - Overridden methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        self.viewControllers = [
            profileNavigationController,
            catalogNavigationController,
            cartNavigationController,
            statisticNavigationController
        ]
    }

    // MARK: - Public Methods
    func showOnboardingIfNeeded() {
        let storageService = StorageService.shared
        guard storageService.environment == .prod else { return }
        if !storageService.wasOnboardingShown {
            let onboardingViewController = OnboardingPageViewController()
            onboardingViewController.modalPresentationStyle = .fullScreen
            present(onboardingViewController, animated: true)
            storageService.wasOnboardingShown = true
        }
    }

    // MARK: - Private Methods
    private func setupUI() {
        tabBar.accessibilityIdentifier = AccessibilityIdentifier.TabBar.view
        tabBar.backgroundColor = A.Colors.whiteDynamic.color
        tabBar.barTintColor = A.Colors.whiteDynamic.color
        tabBar.tintColor = A.Colors.blue.color
        tabBar.unselectedItemTintColor = A.Colors.blackDynamic.color
        tabBar.isTranslucent = false
        tabBar.barStyle = .default
    }

}
