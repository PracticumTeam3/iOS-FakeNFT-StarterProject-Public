//
//  OnboardingPageViewController.swift
//  FakeNFT
//
//  Created by Artem Novikov on 25.10.2023.
//

import UIKit

// MARK: - OnboardingPageViewController
final class OnboardingPageViewController: UIPageViewController {

    // MARK: - Private Properties
    private enum Constants {
        enum PageControl {
            static let topInset: CGFloat = 12
            static let horizontalInset: CGFloat = 16
            static let height: CGFloat = 4
        }
    }

    private var pages: [UIViewController] = [
        OnboardingPage.first,
        OnboardingPage.second,
        OnboardingPage.third
    ]

    private lazy var pageControl: PageControl = {
        let pageControl = PageControl(numberOfPages: pages.count, currentPage: 0)
        pageControl.currentPageIndicatorTintColor = A.Colors.white.color
        pageControl.pageIndicatorTintColor = A.Colors.white.color.withAlphaComponent(0.5)
        return pageControl
    }()

    // MARK: - Initializers
    override init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden Methods
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        if let first = pages.first {
            setViewControllers([first], direction: .forward, animated: true)
        }
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }

    // MARK: - Private Methods
    private func setupLayout() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.PageControl.topInset
            ),
            pageControl.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.PageControl.horizontalInset
            ),
            view.trailingAnchor.constraint(
                equalTo: pageControl.trailingAnchor,
                constant: Constants.PageControl.horizontalInset
            ),
            pageControl.heightAnchor.constraint(equalToConstant: Constants.PageControl.height)
        ])
    }

}

// MARK: - UIPageViewControllerDataSource
extension OnboardingPageViewController: UIPageViewControllerDataSource {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }

        return pages[previousIndex]
    }

    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count else {
            return nil
        }

        return pages[nextIndex]
    }

}

// MARK: - UIPageViewControllerDelegate
extension OnboardingPageViewController: UIPageViewControllerDelegate {

    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }

}
