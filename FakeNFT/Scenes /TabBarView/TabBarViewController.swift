//
//  TabBarViewController.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    weak var viewModel: TabBarViewModel?
    
    init(viewModel: TabBarViewModel?) {
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = A.Colors.whiteDynamic.color
        self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        tabBar.backgroundColor = view.backgroundColor
        tabBar.shadowImage = UIImage()
        tabBar.unselectedItemTintColor = A.Colors.blackDynamic.color
        guard let viewModel = viewModel else { return }
        
        viewModel.catalogeVC.tabBarItem = UITabBarItem(
            title: L.Catalog.title,
            image: A.Icons.TabBar.catalog.image,
            selectedImage: nil
        )
        
        viewModel.cartVC.tabBarItem = UITabBarItem(
            title: L.Cart.title,
            image: A.Icons.TabBar.cart.image,
            selectedImage: nil)
        
        viewModel.profileVC.tabBarItem = UITabBarItem(
            title: L.Profile.title,
            image: A.Icons.TabBar.profile.image,
            selectedImage: nil)
        
        viewModel.statisticVC.tabBarItem = UITabBarItem(
            title: L.Statistics.title,
            image: A.Icons.TabBar.statistic.image,
            selectedImage: nil)
        
        self.viewControllers = [
            viewModel.profileVC,
            viewModel.catalogeVC,
            viewModel.cartVC,
            viewModel.statisticVC
        ]
    }
}
