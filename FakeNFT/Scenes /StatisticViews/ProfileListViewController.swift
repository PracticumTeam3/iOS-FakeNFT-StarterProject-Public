//
//  ProfileListViewController.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 24.10.2023.
//
import UIKit
import ProgressHUD

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
        tableView.allowsSelection = false
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
        ProgressHUD.show()
        viewModel = ProfileListViewModel()
        viewModel?.fetchProfiles { [weak self] in
            DispatchQueue.main.async {
                self?.bind()
                self?.tableView.reloadData()
                ProgressHUD.dismiss()
            }
        }
    }
    // MARK: - Private properties
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
    private func bind() {
            self.viewModel?.onChange = self.tableView.reloadData
    }
    @objc private func showAlert() {
        let alert = UIAlertController(
            title: "Сортировка",
            message: nil,
            preferredStyle: .actionSheet
        )
        let sortByNameAction = UIAlertAction(title: "По имени", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.sortProfilesByName()
        }
        let sortByRatingAction = UIAlertAction(title: "По рейтингу", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel?.sortProfilesByRating()
        }
        let cancel = UIAlertAction(title: "Закрыть", style: .cancel) { _ in }
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
        cell.viewModel = viewModel?.cellViewModel(at: indexPath)
        return cell
    }
}
extension ProfileListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
