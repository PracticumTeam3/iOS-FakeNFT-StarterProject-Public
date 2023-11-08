//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 28.10.2023.
//

import Foundation
import UIKit

final class CollectionViewController: UIViewController {

    var model: CatalogCellModel?

    private let imageHeader: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    private let titleLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = UIColor(named:A.Colors.black.name)
        lable.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        lable.textAlignment = .left
        return lable
    }()

    private let authorLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = UIColor(named:A.Colors.black.name)
        lable.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        lable.text = "Автор коллекции:"
        lable.textAlignment = .left
        return lable
    }()

    private lazy var authorButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(Self.didAuthorButton), for: .touchUpInside)
        return button
    }()

    private let descriptionLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = UIColor(named:A.Colors.black.name)
        lable.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .left
        lable.numberOfLines = 4
        return lable
    }()

    private let collectionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return collection
    }()

    private let loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()

    private let viewModel = CollectionViewModel()
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

    override func viewDidLoad() {
        view.backgroundColor = .white
        collectionCollectionView.dataSource = self
        collectionCollectionView.delegate = self
        setupViews()
        collectionCollectionView.isHidden = true
        loaderView.isHidden = false
        loaderView.startAnimating()
        setData()
        collectionCollectionView.reloadData()
        loaderView.stopAnimating()
        loaderView.isHidden = true

        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem

        collectionCollectionView.isHidden = false
        guard let model = model else {return}
        viewModel.getUsers(id:model.author)
        viewModel.getNFTs(nfts: model.nfts)
        viewModel.getFavouriteNFTs()
        viewModel.bindCart()
        viewModel.onChange = {
            DispatchQueue.main.async {
                self.collectionCollectionView.reloadData()
                self.loaderView.stopAnimating()
                self.loaderView.isHidden = true
                self.collectionCollectionView.isHidden = false
                self.setData()
            }
        }
    }

    private func setData () {
        if let image = model?.imageCollection.addingPercentEncoding(
            withAllowedCharacters: .urlFragmentAllowed) {
            let url = URL(string: image)
            imageHeader.kf.setImage(with:url)
        }
        titleLable.text = model?.collectionName
        authorButton.setTitle(viewModel.author?.name, for: .normal)
        descriptionLable.text = model?.description
    }

    private func setupViews() {
        view.addSubview(imageHeader)
        view.addSubview(titleLable)
        view.addSubview(authorLable)
        view.addSubview(descriptionLable)
        view.addSubview(authorButton)
        view.addSubview(collectionCollectionView)
        view.addSubview(loaderView)

        NSLayoutConstraint.activate([
            imageHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            imageHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            imageHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            imageHeader.heightAnchor.constraint(equalToConstant: 310)
        ])
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: imageHeader.bottomAnchor, constant: 16),
            titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 13),
            authorLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLable.topAnchor.constraint(equalTo: authorLable.bottomAnchor, constant: 5),
            descriptionLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            authorButton.leadingAnchor.constraint(equalTo: authorLable.trailingAnchor, constant: 4),
            authorButton.topAnchor.constraint(equalTo: authorLable.topAnchor, constant: 0),
            authorButton.bottomAnchor.constraint(equalTo: authorLable.bottomAnchor, constant: 0)
        ])

        NSLayoutConstraint.activate([
            collectionCollectionView.topAnchor.constraint(
                equalTo: descriptionLable.bottomAnchor,
                constant: 24
            ),
            collectionCollectionView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 0
            ),
            collectionCollectionView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: 0
            ),
            collectionCollectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: 0
            )
        ])

        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    @objc
    func didAuthorButton() {
        let webView = CollectionWebViewController()
        guard let url = viewModel.author?.website else {return}
        webView.url = url
        self.navigationController?.pushViewController(webView, animated: true)
    }

}// end CollectionViewController

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.NFT.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        if let cell = cell as? CollectionCell {
            if let id = model?.nfts[indexPath.row], let nft = viewModel.NFT[id] {
                cell.setData(
                    collectionCellData: nft,
                    id: id,
                    isFavorite: viewModel.likes.contains(where: {$0 == id}),
                    isInCart: viewModel.carts.contains(where: {$0 == id})
                )
            }
            cell.viewModel = viewModel
        }
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem * 1.8
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}
