//
//  SuccessPayViewController.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 31.10.2023.
//

import UIKit

final class SuccessPayViewController: UIViewController {

    private let successImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = A.Images.Cart.successPay.image
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let successLabel: UILabel = {
        let label = UILabel()
        label.text = L.Cart.successPay
        label.textColor = A.Colors.blackDynamic.color
        label.font = .bold22
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backCatalogeButton: UIButton = {
        let button = UIButton()
        button.setTitle(L.Cart.backCataloge, for: .normal)
        button.setTitleColor(A.Colors.whiteDynamic.color, for: .normal) 
        button.titleLabel?.font = .bold17
        button.backgroundColor = A.Colors.blackDynamic.color
        button.addTarget(self, action: #selector(backCataloge), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = A.Colors.whiteDynamic.color
        view.addSubview(successImageView)
        view.addSubview(successLabel)
        view.addSubview(backCatalogeButton)
        layoutSupport()
    }
    
    private func layoutSupport() {
        NSLayoutConstraint.activate([
            successImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            successImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 152),
            successImageView.widthAnchor.constraint(equalToConstant: 278),
            successImageView.heightAnchor.constraint(equalToConstant: 278)
        ])
        NSLayoutConstraint.activate([
            successLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            successLabel.topAnchor.constraint(equalTo: successImageView.bottomAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            backCatalogeButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            backCatalogeButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            backCatalogeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            backCatalogeButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc
    func backCataloge() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBar = TabBarViewController(viewModel: TabBarViewModel())
        window.rootViewController = tabBar
    }
}
