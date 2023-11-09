//
//  FavouriteNFTViewController.swift
//  FakeNFT
//
//  Created by Artem Novikov on 18.10.2023.
//

import UIKit
import SkeletonView

// MARK: - FavouriteNFTViewController
final class FavouriteNFTViewController: UIViewController {

    // MARK: - Private properties
    private enum Constants {
        enum CollectionView {
            static let itemSize = CGSize(width: 168, height: 80)
            static let interitemSpacing: CGFloat = 7
            static let sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
            static let lineSpacing: CGFloat = 20
        }
    }

    private let favouriteNFTView = FavouriteNFTView()

    private var viewModel: FavouriteNFTViewModelProtocol

    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.searchBar.tintColor = A.Colors.blue.color
        sc.searchBar.placeholder = L.Profile.FavouriteNFT.Search.placeholder
        sc.searchBar.delegate = self
        return sc
    }()

    // MARK: - Initializers
    init(viewModel: FavouriteNFTViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden methods
    override func loadView() {
        view = favouriteNFTView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        bind()
        viewModel.fetchFavouriteNFTs { _ in }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        changeSkeletonState(isShown: true)
    }

    // MARK: - Private methods
    private func configureView() {
        favouriteNFTView.collectionView.dataSource = self
        favouriteNFTView.collectionView.delegate = self
        initRefreshControl()
    }

    private func bind() {
        viewModel.onNFTListLoaded = { [weak self] in
            DispatchQueue.main.async {
                guard let self else { return }
                self.setNeededState()
                self.changeSkeletonState(isShown: false)
                self.favouriteNFTView.collectionView.reloadData()
            }
        }
        viewModel.onNFTListLoadError = { [weak self] error in
            DispatchQueue.main.async {
                guard let self else { return }
                AlertPresenter.show(in: self, model: .favouriteNFTLoadError(message: error))
            }
        }
    }

    private func changeSkeletonState(isShown: Bool) {
        let collectionView = favouriteNFTView.collectionView
        if isShown {
            guard viewModel.nftList == nil else { return }
            collectionView.showAnimatedSkeleton(transition: .crossDissolve(0.25))
        } else {
            collectionView.hideSkeleton(transition: .crossDissolve(0.25))
        }
    }

    private func setNeededState() {
        if let nftList = viewModel.nftList, nftList.isEmpty {
            switch viewModel.state {
            case .search:
                favouriteNFTView.changeState(.nothingFound)
            case .standart:
                favouriteNFTView.changeState(.empty)
            }
        } else {
            favouriteNFTView.changeState(.standart)
        }
    }

    private func configureNavigationBar() {
        let leftButton = UIBarButtonItem(
            image: A.Icons.back.image,
            style: .plain,
            target: self,
            action: #selector(back)
        )
        let ni = navigationItem
        ni.setLeftBarButton(leftButton, animated: false)
        ni.title = L.Profile.FavouriteNFT.title
        ni.searchController = searchController
        ni.hidesSearchBarWhenScrolling = false
        ni.leftBarButtonItem?.accessibilityIdentifier = AccessibilityIdentifier.FavouriteNFTPage.backButton
    }

    private func initRefreshControl() {
        favouriteNFTView.refreshControl = RefreshControl()
        guard let refreshControl = favouriteNFTView.refreshControl else { return }
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        favouriteNFTView.collectionView.addSubview(refreshControl)
        favouriteNFTView.collectionView.refreshControl = refreshControl
    }

    private func removeRefreshControl() {
        favouriteNFTView.refreshControl = nil
        favouriteNFTView.collectionView.refreshControl = nil
    }

    @objc private func back() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func refresh() {
        viewModel.fetchFavouriteNFTs { [weak self] _ in
            DispatchQueue.main.async {
                self?.favouriteNFTView.refreshControl?.endRefreshing()
            }
        }
    }

}

// MARK: - UICollectionViewDataSource
extension FavouriteNFTViewController: SkeletonCollectionViewDataSource {

    func collectionSkeletonView(
        _ skeletonView: UICollectionView,
        cellIdentifierForItemAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        FavouriteNFTCollectionViewCell.defaultReuseIdentifier
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.nftList?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: FavouriteNFTCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        if let nftList = viewModel.nftList {
            cell.delegate = self
            cell.configCell(model: nftList[indexPath.row])
        }
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavouriteNFTViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        Constants.CollectionView.itemSize
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        Constants.CollectionView.interitemSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        Constants.CollectionView.sectionInset
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt: Int
    ) -> CGFloat {
        Constants.CollectionView.lineSpacing
    }

}

// MARK: - FavouriteNFTCollectionViewCellDelegate
extension FavouriteNFTViewController: FavouriteNFTCollectionViewCellDelegate {

    func didTapOnLikeButton(_ cell: FavouriteNFTCollectionViewCell) {
        guard let id = cell.id else { return }
        cell.changeLikeButtonState(isEnabled: false)

        viewModel.unlikeNFT(with: id) { [weak self] result in
            switch result {
            case .success: break
            case .failure(let error):
                DispatchQueue.main.async {
                    guard let self else { return }
                    AlertPresenter.show(
                        in: self,
                        model: .unlikeError(message: error.localizedDescription)
                    )
                    cell.changeLikeButtonState(isEnabled: true)
                }
            }
        }
    }

}

// MARK: - UISearchResultsUpdating
extension FavouriteNFTViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        viewModel.state = .search(searchText: searchController.searchBar.text)
    }

}

// MARK: - UISearchBarDelegate
extension FavouriteNFTViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.state = .search(searchText: "")
        removeRefreshControl()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.state = .standart
        initRefreshControl()
    }

}
