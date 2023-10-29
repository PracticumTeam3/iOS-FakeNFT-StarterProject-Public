//
//  WebViewController.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 26.10.2023.
//

import ProgressHUD
import UIKit
import WebKit

final class WebViewController: UIViewController, WKNavigationDelegate {
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
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        webView.navigationDelegate = self
    }
    
    // MARK: - Public methods
    func configure(viewModel: ProfileCellViewModelProtocol) {
        guard let url = URL(string: viewModel.websiteUrl) else { return }
        webView.load(URLRequest(url: url))
    }
    
    // MARK: - Delegate methods
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        ProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        ProgressHUD.dismiss()
    }
    
    // MARK: - Private methods
    private func addSubviews() {
        view.addSubview(webView)
        view.addSubview(backButton)
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
            backButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    @objc private func backToDetailsVC() {
        dismiss(animated: true)
    }
}
