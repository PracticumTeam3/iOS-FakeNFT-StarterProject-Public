//
//  WebViewController.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 26.10.2023.
//

import ProgressHUD
import UIKit
import WebKit

final class WebViewController: UIViewController {
    private let webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(A.Icons.back.image, for: .normal)
        button.addTarget(self, action: #selector(backToDetailsVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let progressViewContainer: UIView = {
       let view = UIView()
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: ProfileCellViewModelProtocol? {
        didSet {
            webView.load(URLRequest(url: URL(string: viewModel!.websiteUrl)!))
        }
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
    }
    
    // MARK: - Private properties
    private func addSubviews() {
        view.addSubview(webView)
        view.addSubview(backButton)
       // view.addSubview(progressViewContainer)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
       //     progressViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      //      progressViewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      //      progressViewContainer.heightAnchor.constraint(equalToConstant: 30),
       //     progressViewContainer.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
   @objc private func backToDetailsVC() {
        dismiss(animated: true)
    }
}
