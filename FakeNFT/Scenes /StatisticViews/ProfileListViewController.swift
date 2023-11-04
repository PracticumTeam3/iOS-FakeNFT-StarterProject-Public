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
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = A.Colors.whiteDynamic.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy private var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(A.Icons.sort.image, for: .normal)
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
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *),
           traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if traitCollection.userInterfaceStyle == .dark {
                sortButton.setImage(A.Icons.sortDarkMode.image, for: .normal)
            } else {
                sortButton.setImage(A.Icons.sort.image, for: .normal)
            }
        }
    }
    
    // MARK: - Private methods
    private func addSubviews() {
        view.addSubview(topView)
        view.addSubview(sortButton)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: 88),
            sortButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -9),
            sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            sortButton.heightAnchor.constraint(equalToConstant: 42),
            sortButton.widthAnchor.constraint(equalToConstant: 42),
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
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
