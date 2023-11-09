//
//  DetailsProfileViewController.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 26.10.2023.
//

import Kingfisher
import ProgressHUD
import UIKit

final class DetailsProfileViewController: UIViewController {
    // MARK: - Private properties
    private let nameUser: UILabel = {
        let label = UILabel()
        label.text = "Placeholder"
        label.font = .Bold.medium
        label.numberOfLines = 0
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let infoUser: UILabel = {
        let label = UILabel()
        label.font = .Regular.small
        label.numberOfLines = 0
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let photoUser: UIImageView = {
        let image = UIImageView()
        let placeholderImage = UIImage(systemName: "person.crop.circle.fill")
        let imageWithColor = placeholderImage?.withTintColor(
            A.Colors.gray.color,
            renderingMode: .alwaysOriginal)
        image.image = imageWithColor
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    lazy private var webSiteUserButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .Regular.medium
        button.setTitle(L.Statistics.goToWebsite, for: .normal)
        button.tintColor = A.Colors.blackDynamic.color
        button.layer.borderWidth = 1
        button.layer.borderColor = A.Colors.blackDynamic.color.cgColor
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushToWebSiteUser), for: .touchUpInside)
        return button
    }()

    private let collectionNFTLabel: UILabel = {
        let label = UILabel()
        label.text = L.Statistics.collectionNFT
        label.font = .Bold.small
        label.numberOfLines = 0
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let countNFTLabel: UILabel = {
        let label = UILabel()
        label.text = "(112)"
        label.font = .Bold.small
        label.numberOfLines = 0
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy private var containerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pushToUserCollections), for: .touchUpInside)
        return button
    }()

    lazy private var forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(A.Icons.forward.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = A.Colors.blackDynamic.color
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Public properties
    private var viewModel: ProfileCellViewModelProtocol?

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = A.Colors.whiteDynamic.color
        addSubviews()
        setupConstraints()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProgressHUD.dismiss()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            webSiteUserButton.layer.borderColor = A.Colors.blackDynamic.color.cgColor
    }

    // MARK: - Public methods
    func configure(viewModel: ProfileCellViewModelProtocol) {
        countNFTLabel.text = "(\(viewModel.nfts.count))"
        nameUser.text = viewModel.profileName
        infoUser.attributedText = mutableString(text: viewModel.infoUser)
        photoUser.kf.setImage(with: URL(string: viewModel.profileImage))
        self.viewModel = viewModel
    }

    // MARK: - Private methods
    private func addSubviews() {
        view.addSubview(nameUser)
        view.addSubview(photoUser)
        view.addSubview(infoUser)
        view.addSubview(webSiteUserButton)
        view.addSubview(containerButton)
        view.addSubview(countNFTLabel)
        view.addSubview(collectionNFTLabel)
        view.addSubview(forwardButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoUser.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoUser.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            photoUser.widthAnchor.constraint(equalToConstant: 70),
            photoUser.heightAnchor.constraint(equalToConstant: 70),
            nameUser.centerYAnchor.constraint(equalTo: photoUser.centerYAnchor),
            nameUser.leadingAnchor.constraint(equalTo: photoUser.trailingAnchor, constant: 16),
            nameUser.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoUser.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            infoUser.topAnchor.constraint(equalTo: photoUser.bottomAnchor, constant: 20),
            infoUser.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            webSiteUserButton.topAnchor.constraint(equalTo: infoUser.bottomAnchor, constant: 28),
            webSiteUserButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            webSiteUserButton.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            webSiteUserButton.heightAnchor.constraint(equalToConstant: 40),
            containerButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            containerButton.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            containerButton.heightAnchor.constraint(equalToConstant: 55),
            containerButton.topAnchor.constraint(equalTo: webSiteUserButton.bottomAnchor, constant: 40),
            collectionNFTLabel.leadingAnchor.constraint(equalTo: containerButton.leadingAnchor),
            collectionNFTLabel.centerYAnchor.constraint(equalTo: containerButton.centerYAnchor),
            countNFTLabel.leadingAnchor.constraint(equalTo: collectionNFTLabel.trailingAnchor, constant: 16),
            countNFTLabel.centerYAnchor.constraint(equalTo: containerButton.centerYAnchor),
            forwardButton.trailingAnchor.constraint(equalTo: containerButton.trailingAnchor),
            forwardButton.centerYAnchor.constraint(equalTo: containerButton.centerYAnchor)
        ])
    }

    private func mutableString(text: String) -> NSMutableAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 5
        let mutableText = NSMutableAttributedString(string: text)
        mutableText.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraph,
            range: NSRange(
                location: 0,
                length: mutableText.length
            )
        )
        return mutableText
    }

    private func setupNavigationBar() {
        let backImageBackButton = UIImage(asset: A.Icons.back)
        navigationController?.navigationBar.backIndicatorImage = backImageBackButton
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImageBackButton
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        navigationItem.backBarButtonItem?.tintColor = A.Colors.blackDynamic.color
    }

    @objc private func backToProfileList() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func pushToWebSiteUser() {
        guard
            let viewModel,
            let url = URL(string: viewModel.websiteUrl)
        else {
            AlertPresenter.show(in: self, model: .urlParsingError)
            return
        }
        let webViewModel = WebViewModel()
        let viewController = WebViewController(webViewModel: webViewModel,
                                               url: url,
                                               presentation: .navigation)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func pushToUserCollections() {
        let collectionVC = CollectionNFTViewController()
        guard let viewModel = viewModel else { return }
        collectionVC.configure(nftsID: viewModel.nfts)
        navigationController?.pushViewController(collectionVC, animated: true)
    }
}
