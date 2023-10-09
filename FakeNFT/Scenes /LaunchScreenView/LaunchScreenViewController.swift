//
//  LaunchScreenViewController.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit

final class LaunchScreenViewController: UIViewController {
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        let image = A.Icons.splashScreen.image
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = A.Colors.whiteDynamic.color
        view.addSubview(logoImageView)
        viewsConstrains()
        nextViews()
    }
    private func viewsConstrains() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    private func nextViews() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let nextView = TabBarViewController(viewModel: TabBarViewModel())
        window.rootViewController = nextView
    }
}
