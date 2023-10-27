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
    private var profileNavigationController: UINavigationController {
        let navigationController = ProfileNavigationController()
        let viewModel = ProfileViewModel()
        let viewController = ProfileViewController(viewModel: viewModel)

        navigationController.viewControllers = [viewController]

        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: A.Icons.TabBar.profile.image,
            selectedImage: nil
        )
        navigationController.title = L.Profile.title
        return navigationController
    }

    // MARK: - Overridden methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        self.viewControllers = [profileNavigationController]
    }

    // MARK: - Public Methods
    func showOnboardingIfNeeded() {
        let storageService = StorageService.shared
        if !storageService.wasOnboardingShown {
            let onboardingViewController = OnboardingPageViewController()
            onboardingViewController.modalPresentationStyle = .fullScreen
            present(onboardingViewController, animated: true)
            storageService.wasOnboardingShown = true
        }
    }

    // MARK: - Private Methods
    private func setupUI() {
        tabBar.backgroundColor = A.Colors.whiteDynamic.color
        tabBar.barTintColor = A.Colors.whiteDynamic.color
        tabBar.tintColor = A.Colors.blue.color
        tabBar.isTranslucent = false
        tabBar.barStyle = .default
    }

}
