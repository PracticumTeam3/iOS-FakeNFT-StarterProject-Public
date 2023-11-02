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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = A.Colors.whiteDynamic.color
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = A.Colors.whiteDynamic.color
        return view
    }()
    
    private lazy var contenSize: CGSize = {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }()
    
    private var topImageViewConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = A.Colors.whiteDynamic.color
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(successImageView)
        contentView.addSubview(successLabel)
        view.addSubview(backCatalogeButton)
        layoutSupport()
        view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateContentSize()
    }

    private func layoutSupport() {
        topImageViewConstraint = successImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        topImageViewConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            successImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            successLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
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
    private func backCataloge() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBar = TabBarViewController(viewModel: TabBarViewModel())
        window.rootViewController = tabBar
    }
    
    private func updateContentSize() {
        if traitCollection.verticalSizeClass == .compact {
            topImageViewConstraint?.constant = 20
            contenSize = CGSize(width: view.frame.width,
                                height: 20 + successImageView.frame.height + 20 +
                                        successLabel.frame.height + 20 + backCatalogeButton.frame.height + 16)
        } else {
            topImageViewConstraint?.constant = 196
            contenSize = CGSize(width: view.frame.width,
                                height: view.frame.height)
        }
        scrollView.contentSize = contenSize
        scrollView.frame = view.bounds
        contentView.frame.size = contenSize
    }
    
}
