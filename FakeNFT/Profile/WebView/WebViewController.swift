//
//  WebViewController.swift
//  FakeNFT
//
//  Created by Artem Novikov on 09.10.2023.
//

import UIKit
import WebKit

// MARK: - WebViewController
final class WebViewController: UIViewController {

    // MARK: - Private properties
    private let webViewModel: WebViewModelProtocol
    private let url: URL
    private var estimatedProgressObservation: NSKeyValueObservation?
    private let webView: WebView
    private let presentation: WebViewPresentation

    // MARK: - Initializers
    init(webViewModel: WebViewModelProtocol, url: URL, presentation: WebViewPresentation) {
        self.presentation = presentation
        self.webView = WebView(presentation: presentation)
        self.webViewModel = webViewModel
        self.url = url
        super.init(nibName: nil, bundle: nil)
        webView.delegate = self
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods
    override func loadView() {
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerEstimatedProgressObserver()
        bind()
        configureNavigationBarIfNeeded()
        load(url: url)
    }

    // MARK: - Private methods
    private func bind() {
        webViewModel.onProgressChange = { [weak self] progress in
            self?.setProgressValue(progress)
        }
        webViewModel.onProgressHide = { [weak self] isHidden in
            self?.setProgressHidden(isHidden)
        }
    }

    private func registerEstimatedProgressObserver() {
        estimatedProgressObservation = webView.webView.observe(
            \.estimatedProgress,
             options: [],
             changeHandler: { [weak self] _, _ in
                 guard let self else { return }
                 self.webViewModel.didUpdateProgressValue(self.webView.webView.estimatedProgress)
             }
        )
    }

    private func load(url: URL) {
        let request = URLRequest(url: url)
        webView.webView.load(request)
    }

    private func setProgressValue(_ newValue: Float) {
        webView.progressView.progress = newValue
    }

    private func setProgressHidden(_ isHidden: Bool) {
        webView.progressView.isHidden = isHidden
    }

    private func configureNavigationBarIfNeeded() {
        guard presentation == .navigation else { return }
        let leftButton = UIBarButtonItem(
            image: A.Icons.back.image,
            style: .plain,
            target: self,
            action: #selector(back)
        )
        navigationItem.setLeftBarButton(leftButton, animated: false)
        navigationItem.title = L.Profile.AboutDeveloper.title
        navigationItem.leftBarButtonItem?.accessibilityIdentifier = AccessibilityIdentifier.WebView.backButton
    }

    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - WebViewController
extension WebViewController: WebViewDelegate {
    func didTapCloseButton() {
        dismiss(animated: true)
    }
}
