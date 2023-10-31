//
//  CartWebViewController.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 31.10.2023.
//

import ProgressHUD
import UIKit
import WebKit

final class CartWebViewController: UIViewController {
    
    private let viewModel: CartWebViewModel
    
    private let webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = A.Colors.whiteDynamic.color
        view.progressTintColor = A.Colors.gray.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: CartWebViewModel) {
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSupport()
        view.addSubview(webView)
        view.addSubview(progressView)
        layoutSupport()
        bind()
        loadWebView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new,
                            context: nil)
        progressHUD(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            viewModel.didUpdateProgressValue(webView.estimatedProgress)
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    private func viewSupport() {
        view.backgroundColor = A.Colors.whiteDynamic.color
        let leftBarButtom = UIBarButtonItem(image: A.Icons.backward.image,
                                            style: .done,
                                            target: self,
                                            action: #selector(backVC))
        leftBarButtom.tintColor = A.Colors.blackDynamic.color
        navigationItem.leftBarButtonItem = leftBarButtom
    }

    private func layoutSupport() {
        NSLayoutConstraint.activate([
            webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.leftAnchor.constraint(equalTo: view.leftAnchor),
            progressView.rightAnchor.constraint(equalTo: view.rightAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    private func loadWebView() {
        guard let request = viewModel.getRequest() else { return }
        webView.load(request)
    }
    
    private func bind() {
        viewModel.$progressHUDIsActive.bind { [weak self] isShow in
            DispatchQueue.main.async {
                self?.progressHUD(isShow)
            }
        }
        viewModel.$progress.bind { [weak self] newProgress in
            DispatchQueue.main.async {
                self?.changeProgress(newProgress)
            }
        }
        viewModel.$progressIsHidden.bind { [weak self] ishidden in
            DispatchQueue.main.async {
                self?.progressView.isHidden = ishidden
            }
        }
    }
    
    @objc
    private func backVC() {
        navigationController?.popViewController(animated: true)
    }
    
    private func changeProgress(_ newValue: Double) {
        progressView.progress = Float(newValue)
    }
        
    private func progressHUD(_ isShow: Bool) {
        if isShow {
            ProgressHUD.show()
        } else {
            ProgressHUD.dismiss()
        }
    }
    
}
