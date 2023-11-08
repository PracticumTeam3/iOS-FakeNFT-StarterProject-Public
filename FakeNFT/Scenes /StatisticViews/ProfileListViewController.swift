//
//  ProfileListViewController.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 24.10.2023.
//
import ProgressHUD
import UIKit

final class ProfileListViewController: UIViewController {
    // MARK: - Private properties
    lazy private var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(A.Icons.sort.image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = A.Colors.blackDynamic.color
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = A.Colors.whiteDynamic.color
        tableView.separatorStyle = .none
        tableView.register(ProfileTableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var viewModel: ProfileListViewModelProtocol?
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel = ProfileListViewModel(delegate: self)
        fetchProfiles()
        appearanceNavBarAndTabBar()
    }
    
    // MARK: - Private methods
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func appearanceNavBarAndTabBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let rightButton = UIBarButtonItem(customView: sortButton)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButton
        let backImageBackButton = UIImage(asset: A.Icons.back)
        navigationController?.navigationBar.backIndicatorImage = backImageBackButton
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImageBackButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = A.Colors.blackDynamic.color
        tabBarController?.tabBar.shadowImage = UIImage()
        tabBarController?.tabBar.backgroundImage = UIImage()
    }
    
    private func fetchProfiles() {
        ProgressHUD.show()
        viewModel?.fetchProfiles { [weak self] in
            DispatchQueue.main.async {
                self?.bind()
                self?.tableView.reloadData()
                ProgressHUD.dismiss()
            }
        }
    }
    
    private func bind() {
        self.viewModel?.onChange = self.tableView.reloadData
    }
    
    @objc private func showAlert() {
        let alert = UIAlertController(
            title: L.Statistics.sorted,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let sortByNameAction = UIAlertAction(
            title: L.Statistics.byName,
            style: .default
        ) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.sortProfilesByName()
        }
        
        let sortByRatingAction = UIAlertAction(
            title: L.Statistics.byRating,
            style: .default
        ) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.sortProfilesByRating()
        }
        
        let cancel = UIAlertAction(
            title: L.Statistics.close,
            style: .cancel
        ) { _ in }
        alert.addAction(sortByNameAction)
        alert.addAction(sortByRatingAction)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

// MARK: - Extensions
extension ProfileListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        guard let viewModel = viewModel?.cellViewModel(at: indexPath) else { return UITableViewCell() }
        cell.configure(viewModel: viewModel)
        cell.selectionStyle = .none
        return cell
    }
}

extension ProfileListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsProfileViewController()
        guard let viewModel = viewModel?.cellViewModel(at: indexPath) else { return }
        vc.configure(viewModel: viewModel)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfileListViewController: ProfileListViewModelDelegate {
    func showAlertWithError() {
        ProgressHUD.dismiss()
        let alert = UIAlertController(
            title: nil,
            message: L.Statistics.error,
            preferredStyle: .alert
        )
        let action = UIAlertAction(
            title: L.Statistics.errorAction,
            style: .default) { _ in
                self.fetchProfiles()
            }
        let cancel = UIAlertAction(
            title: L.Statistics.errorActionCancel,
            style: .default) { _ in  }
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
