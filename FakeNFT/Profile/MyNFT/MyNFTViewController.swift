//
//  MyNFTViewController.swift
//  FakeNFT
//
//  Created by Artem Novikov on 11.10.2023.
//

import UIKit
import SkeletonView

// MARK: - MyNFTViewController
final class MyNFTViewController: UIViewController {

    // MARK: - Private properties
    private let myNFTView = MyNFTView()
    private var viewModel: MyNFTViewModelProtocol
    private lazy var sortButton = UIBarButtonItem(
        image: A.Icons.sort.image,
        style: .plain,
        target: self,
        action: #selector(sort)
    )

    // MARK: - Initializers
    init(viewModel: MyNFTViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods
    override func loadView() {
        view = myNFTView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        viewModel.fetchNFTs { _ in }
        bind()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showSkeletonIfNeeded()
    }

    // MARK: - Private methods
    private func bind() {
        viewModel.onNFTListLoaded = { [weak self] in
            DispatchQueue.main.async {
                guard let self else { return }
                self.setNeededState()
                self.changeSortButtonState(isEnabled: true)
                self.myNFTView.tableView.reloadData()
            }
        }
        viewModel.onNFTListLoadError = { [weak self] error in
            DispatchQueue.main.async {
                guard let self else { return }
                AlertPresenter.show(in: self, model: .myNFTLoadError(message: error))
            }
        }
    }

    private func configureView() {
        myNFTView.tableView.dataSource = self
        myNFTView.refreshControl.addTarget(self,
                                           action: #selector(refresh),
                                           for: .valueChanged)
    }

    private func configureNavigationBar() {
        let leftButton = UIBarButtonItem(
            image: A.Icons.back.image,
            style: .plain,
            target: self,
            action: #selector(back)
        )
        navigationItem.setLeftBarButton(leftButton, animated: false)
        navigationItem.setRightBarButton(sortButton, animated: false)
        navigationItem.title = L.Profile.MyNFT.title
        changeSortButtonState(isEnabled: false)
    }

    private func setNeededState() {
        if let nftList = viewModel.nftList, nftList.isEmpty {
            myNFTView.changeState(.empty)
            navigationItem.setRightBarButton(nil, animated: false)
        } else {
            myNFTView.changeState(.standart)
            navigationItem.setRightBarButton(sortButton, animated: false)
        }
    }

    private func showSkeletonIfNeeded() {
        if viewModel.nftList == nil {
            myNFTView.tableView.visibleCells.forEach {
                $0.showAnimatedSkeleton(transition: .crossDissolve(0.25))
            }
        }
    }

    private func changeSortButtonState(isEnabled: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    }

    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func sort() {
        AlertPresenter.show(in: self, model: .sortActionSheet(
            priceCompletion: { [weak self] in
                self?.viewModel.sortType = .byPrice
            },
            ratingCompletion: { [weak self] in
                self?.viewModel.sortType = .byRating
            },
            nameCompletion: { [weak self] in
                self?.viewModel.sortType = .byName
            })
        )
    }

    @objc private func refresh() {
        viewModel.fetchNFTs { [weak self] _ in
            DispatchQueue.main.async {
                self?.myNFTView.refreshControl.endRefreshing()
            }
        }
    }

}

// MARK: - UITableViewDataSource
extension MyNFTViewController: SkeletonTableViewDataSource {

    func collectionSkeletonView(
        _ skeletonView: UITableView,
        cellIdentifierForRowAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        MyNFTTableViewCell.defaultReuseIdentifier
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.nftList?.count ?? 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyNFTTableViewCell = tableView.dequeueReusableCell()
        if let nftList = viewModel.nftList {
            cell.hideSkeleton(transition: .crossDissolve(0.25))
            cell.configCell(model: nftList[indexPath.row])
        }
        return cell
    }

}