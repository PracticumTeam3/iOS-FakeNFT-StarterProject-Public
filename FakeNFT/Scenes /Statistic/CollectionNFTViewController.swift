//
//  CollectionNFTViewController.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 01.11.2023.
//

import ProgressHUD
import UIKit

final class CollectionNFTViewController: UIViewController {
    // MARK: - Types
    struct Parameters {
        let countCells: CGFloat
        let heightCell: CGFloat
        let xSpacing: CGFloat
        let ySpacing: CGFloat
    }

    // MARK: - Private Properties
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        collectionView.backgroundColor = A.Colors.whiteDynamic.color
        collectionView.register(
            CollectionNFTCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let parameters = Parameters(
        countCells: 3,
        heightCell: 192,
        xSpacing: 9,
        ySpacing: 8
    )

    private var viewModel: CollectionNFTViewModelProtocol?

    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L.Statistics.collectionNFT
        view.backgroundColor = A.Colors.whiteDynamic.color
        addSubviews()
        setupConstraints()
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchNFTs()
    }

    // MARK: - Public methods
    func configure(nftsID: [String]) {
        viewModel = CollectionNFTViewModel(nftIDs: nftsID)
        viewModel?.delegate = self
    }

    // MARK: - Private methods
    private func addSubviews() {
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func fetchNFTs() {
        ProgressHUD.show()
        viewModel?.fetchNFT { [weak self] in
                self?.collectionView.reloadData()
                ProgressHUD.dismiss()
            let n = self?.viewModel?.nftsIsEmpty()
            if n! {
                self?.showAlertWithError()
            }
        }
    }

    private func showAlertWithError() {
        let alert = UIAlertController(
            title: nil,
            message: L.Statistics.isEmpty,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(
            title: L.Statistics.errorActionCancel,
            style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

// MARK: - Extension UICollectionViewDataSource
extension CollectionNFTViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel?.numberOfRows() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as? CollectionNFTCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel?.cellViewModel(
            at: indexPath,
            delegate: self
        ) else { return UICollectionViewCell() }
        cell.configure(viewModel: viewModel)
        return cell
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout
extension CollectionNFTViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let widthCollection = collectionView.bounds.size.width
        let width = (widthCollection - (2 * parameters.xSpacing)) / parameters.countCells
        return CGSize(width: width, height: parameters.heightCell)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        parameters.ySpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        parameters.xSpacing
    }
}

extension CollectionNFTViewController: CollectionNFTCellViewModelDelegate {
    func reloadItems(indexPath: IndexPath) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadItems(at: [indexPath])
        }
    }

    func showAlert() {
        showAlertWithError()
    }
}

extension CollectionNFTViewController: CollectionNFTViewModelDelegate {
    func showAlertNftModel() {
        showAlertWithError()
    }
}
