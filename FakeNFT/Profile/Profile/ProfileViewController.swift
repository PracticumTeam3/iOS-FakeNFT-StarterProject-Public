//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by Artem Novikov on 05.10.2023.
//

import UIKit

// MARK: - ProfileViewController
final class ProfileViewController: UIViewController {

    // MARK: - Private properties
    private enum Constants {
        enum TableView {
            static let height: CGFloat = 54
        }
    }
    private let profileView: ProfileView
    private let viewModel: ProfileViewModel
    private var editButton: UIBarButtonItem? {
        navigationItem.rightBarButtonItem
    }

    // MARK: - Initializers
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        self.profileView = ProfileView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods
    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        bind()
        viewModel.fetchProfile { _ in }
    }

    // MARK: - Private methods
    private func bind() {
        viewModel.onProfileInfoChanged = { [weak self] in
            DispatchQueue.main.async {
                guard let self else { return }
                self.profileView.changeSkeletonState(isShown: false)
                self.editButton?.isEnabled = true
                self.profileView.updateUI()
            }
        }
        viewModel.onFetchError = { [weak self] error in
            DispatchQueue.main.async {
                guard let self else { return }
                AlertPresenter.show(in: self, model: .profileFetchError(message: error) {
                    self.viewModel.fetchProfile { _ in }
                })
            }
        }
        viewModel.onEditError = { [weak self] error in
            DispatchQueue.main.async {
                guard let self else { return }
                AlertPresenter.show(in: self, model: .profileEditError(message: error) {
                    self.viewModel.fetchProfile { _ in }
                })
            }
        }
    }

    private func configureNavigationBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        let rightButton = UIBarButtonItem(
            image: A.Icons.edit.image,
            style: .plain,
            target: self,
            action: #selector(presentEditProfileViewController)
        )
        navigationItem.setRightBarButton(rightButton, animated: false)
        navBar.tintColor = A.Colors.blackDynamic.color
    }

    private func configureView() {
        let gestureRecognizer = UITapGestureRecognizer(
           target: self,
           action: #selector(presentWebViewController)
        )
        profileView.tableView.dataSource = self
        profileView.tableView.delegate = self
        profileView.initialize(gestureRecognizer: gestureRecognizer)
        profileView.refreshControl.addTarget(self,
                                             action: #selector(refresh),
                                             for: .valueChanged)
        if viewModel.model == nil {
            profileView.changeSkeletonState(isShown: true)
            editButton?.isEnabled = false
        }
    }

    private func pushMyNFTViewController() {
        let viewModel = MyNFTViewModel()
        let viewController = MyNFTViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func pushFavouriteNFTViewController() {
        let viewModel = FavouriteNFTViewModel()
        let viewController = FavouriteNFTViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func pushAboutWebViewController() {
        guard
            let profile = viewModel.model,
            let url = URL(string: profile.website)
        else {
            AlertPresenter.show(in: self, model: .urlParsingError)
            return
        }
        let viewModel = WebViewModel()
        let viewController = WebViewController(webViewModel: viewModel,
                                               url: url,
                                               presentation: .navigation)
        navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func presentEditProfileViewController() {
        let vc = EditProfileViewController(viewModel: viewModel)
        present(vc, animated: true)
    }

    @objc private func presentWebViewController() {
        guard let model = viewModel.model else { return }
        guard let url = URL(string: model.website) else {
            AlertPresenter.show(in: self, model: .urlParsingError)
            return
        }
        let viewModel = WebViewModel()
        let vc = WebViewController(webViewModel: viewModel, url: url, presentation: .modal)
        present(vc, animated: true)
    }

    @objc private func refresh() {
        viewModel.fetchProfile { [weak self] _ in
            DispatchQueue.main.async {
                self?.profileView.refreshControl.endRefreshing()
            }
        }
    }

}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell()
        cell.configCell(label: viewModel.cells[indexPath.row].name)
        return cell
    }

}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.TableView.height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = viewModel.cells[indexPath.row]
        switch cell {
        case .myNFT: pushMyNFTViewController()
        case .favouriteNFT: pushFavouriteNFTViewController()
        case .about: pushAboutWebViewController()
        }
    }

}
