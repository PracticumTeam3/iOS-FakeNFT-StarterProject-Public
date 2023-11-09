//
//  PageControl.swift
//  FakeNFT
//
//  Created by Artem Novikov on 26.10.2023.
//

import UIKit

// MARK: - PageControl
final class PageControl: UIView {

    // MARK: - Public Properties
    private(set) var numberOfPages: Int

    var currentPage: Int {
        didSet {
            reloadView()
        }
    }

    /// The tint color for the currently-selected indicators. Default is nil.
    var currentPageIndicatorTintColor: UIColor?

    /// The tint color for non-selected indicators. Default is nil.
    var pageIndicatorTintColor: UIColor?

    // MARK: - Private Properties
    private enum Constants {
        static let spacing: CGFloat = 8
        static let cornerRadius: CGFloat = 2
    }

    // MARK: - Initializers
    init(numberOfPages: Int, currentPage: Int) {
        self.numberOfPages = numberOfPages
        self.currentPage = currentPage
        super.init(frame: .zero)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        for (i, view) in subviews.enumerated() {
            view.layer.masksToBounds = true
            view.layer.cornerRadius = Constants.cornerRadius
            view.frame = CGRect(
                x: ((bounds.width / CGFloat(numberOfPages)) * CGFloat(i)) + Constants.spacing,
                y: 0,
                width: CGFloat(bounds.width / CGFloat(numberOfPages) - Constants.spacing),
                height: bounds.height
            )
        }
        reloadView()
    }

    // MARK: - Private Methods
    private func reloadView() {
        subviews.forEach { $0.backgroundColor = pageIndicatorTintColor }
        subviews[currentPage].backgroundColor = currentPageIndicatorTintColor
    }

    private func configureView() {
        backgroundColor = .clear
        (0..<numberOfPages).forEach { _ in
            addSubview(UIView())
        }
    }

}
