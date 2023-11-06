//
//  SuccessPayViewController.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 31.10.2023.
//

import UIKit

final class SuccessPayViewController: UIViewController {

    private enum Constants {
        enum ImageView {
            static let topInsetVertOrient: CGFloat = 196
            static let topInsetGorOrient: CGFloat = 20
        }
        enum Label {
            static let topInset: CGFloat = 20
        }
        enum Button {
            static let cornerRadius: CGFloat = 16
            static let topInset: CGFloat = 20
            static let leftInset: CGFloat = 16
            static let rightInset: CGFloat = 16
            static let bottomInset: CGFloat = 16
            static let height: CGFloat = 60
        }
    }

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
        label.font = .Bold.medium
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var backCatalogeButton: UIButton = {
        let button = UIButton()
        button.setTitle(L.Cart.backCataloge, for: .normal)
        button.setTitleColor(A.Colors.whiteDynamic.color, for: .normal)
        button.titleLabel?.font = .Bold.small
        button.backgroundColor = A.Colors.blackDynamic.color
        button.addTarget(self, action: #selector(backCatalog), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.Button.cornerRadius
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
        topImageViewConstraint = successImageView.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.ImageView.topInsetVertOrient
        )
        topImageViewConstraint?.isActive = true

        NSLayoutConstraint.activate([
            successImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            successLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            successLabel.topAnchor.constraint(equalTo: successImageView.bottomAnchor,
                                              constant: Constants.Label.topInset)
        ])
        NSLayoutConstraint.activate([
            backCatalogeButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                     constant: Constants.Button.leftInset),
            backCatalogeButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                      constant: -Constants.Button.rightInset),
            backCatalogeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                       constant: -Constants.Button.bottomInset),
            backCatalogeButton.heightAnchor.constraint(equalToConstant: Constants.Button.height)
        ])
    }

    @objc
    private func backCatalog() {
        guard let window = UIApplication.shared.windows.first else {
            print("Error SuccessPayViewController: backCatalog")
            return
        }
        let tabBar = TabBarController()
        window.rootViewController = tabBar
    }

    private func updateContentSize() {
        if traitCollection.verticalSizeClass == .compact {
            topImageViewConstraint?.constant = Constants.ImageView.topInsetGorOrient
            contenSize = CGSize(width: view.frame.width,
                                height: Constants.ImageView.topInsetGorOrient +
                                        successImageView.frame.height +
                                        Constants.Label.topInset +
                                        successLabel.frame.height +
                                        Constants.Button.topInset +
                                        backCatalogeButton.frame.height +
                                        Constants.Button.bottomInset)
        } else {
            topImageViewConstraint?.constant = Constants.ImageView.topInsetVertOrient
            contenSize = CGSize(width: view.frame.width,
                                height: view.frame.height)
        }
        scrollView.contentSize = contenSize
        scrollView.frame = view.bounds
        contentView.frame.size = contenSize
    }

}
