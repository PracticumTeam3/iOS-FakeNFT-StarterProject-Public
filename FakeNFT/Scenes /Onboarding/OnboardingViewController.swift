//
//  OnboardingViewController.swift
//  FakeNFT
//
//  Created by Artem Novikov on 25.10.2023.
//

import UIKit

// MARK: - OnboardingViewController
final class OnboardingViewController: UIViewController {

    // MARK: - Private Properties
    private enum Constants {
        static let horizontalInset: CGFloat = 16
        enum Title {
            static let topInset: CGFloat = 186
        }
        enum Subtitle {
            static let topInset: CGFloat = 12
        }
        enum Button {
            static let cornerRadius: CGFloat = 16
            static let height: CGFloat = 60
            static let bottomInset: CGFloat = 66
        }
        enum CloseButton {
            static let topInset: CGFloat = 28
            static let trailingInset: CGFloat = 16
            static let widthAndHeight: CGFloat = 42
        }
    }

    private let props: OnboardingViewControllerProps

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = A.Colors.white.color
        label.font = .Bold.large
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = A.Colors.white.color
        label.font = .Regular.medium
        label.numberOfLines = 0
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(A.Icons.close.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = A.Colors.white.color
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        return button
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = A.Colors.black.color
        button.layer.cornerRadius = Constants.Button.cornerRadius
        button.layer.masksToBounds = true
        button.setTitleColor(A.Colors.white.color, for: .normal)
        button.titleLabel?.font = .Bold.small
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        return button
    }()

    // MARK: - Initializers
    init(props: OnboardingViewControllerProps) {
        self.props = props
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        addGradient(frame: view.frame,
                    colors: [A.Colors.black.color, A.Colors.black.color.withAlphaComponent(0)])
    }

    // MARK: - Private Methods
    private func setupUI() {
        imageView.image = props.image
        titleLabel.text = props.title
        subtitleLabel.text = props.subtitle
        button.setTitle(props.buttonText, for: .normal)
    }

    private func setupLayout() {
        [imageView, titleLabel, subtitleLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: Constants.Title.topInset),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Constants.horizontalInset),
            view.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor,
                                           constant: Constants.horizontalInset)
        ])

        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                               constant: Constants.Subtitle.topInset),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: Constants.horizontalInset),
            view.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor,
                                           constant: Constants.horizontalInset)
        ])
        layoutNeededButton()
    }

    private func layoutNeededButton() {
        if props.buttonText == nil {
            view.addSubview(closeButton)
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                 constant: Constants.CloseButton.topInset),
                view.trailingAnchor.constraint(equalTo: closeButton.trailingAnchor,
                                               constant: Constants.CloseButton.trailingInset),
                closeButton.widthAnchor.constraint(equalToConstant: Constants.CloseButton.widthAndHeight),
                closeButton.heightAnchor.constraint(equalToConstant: Constants.CloseButton.widthAndHeight)
            ])
        } else {
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Constants.horizontalInset),
                view.trailingAnchor.constraint(equalTo: button.trailingAnchor,
                                               constant: Constants.horizontalInset),
                button.heightAnchor.constraint(equalToConstant: Constants.Button.height),
                view.bottomAnchor.constraint(equalTo: button.bottomAnchor,
                                             constant: Constants.Button.bottomInset)
            ])
        }
    }

    private func addGradient(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map { $0.cgColor }
        imageView.layer.addSublayer(gradient)
    }

    @objc private func onTap() {
        dismiss(animated: true)
    }

}
