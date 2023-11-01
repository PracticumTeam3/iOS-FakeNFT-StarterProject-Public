//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 28.10.2023.
//

import Foundation
import UIKit
// swiftlint:disable trailing_whitespace
class CollectionViewController: UIViewController {
    let imageCellFirst: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let imageCellSecond: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let imageCellThird: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let stackImage: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 0
        stack.layer.cornerRadius = 12
        stack.layer.masksToBounds = true
        stack.backgroundColor = .blue
        return stack
    }()

    let titleLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = UIColor(named: "black")
        lable.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        lable.textAlignment = .left
        lable.text = "заголовок"
        return lable
    }()

    let authorLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = UIColor(named: "black")
        lable.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .left
        lable.text = "Автор коллекции:"
        return lable
    }()

    let authorButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(Self.didAuthorButton), for: .touchUpInside)
        button.setTitle("John Doe", for: .normal)
        return button
    }()

    let descriptionLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = UIColor(named: "black")
        lable.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        lable.textAlignment = .left
        lable.numberOfLines = 4
        lable.text = "Персиковый — как облака над закатным солнцем в океане. В этой коллекции совмещены трогательная нежность и живая игривость сказочных зефирных зверей."
        return lable
    }()

    let collectionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return collection
    }()

    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)

    override func viewDidLoad() {
        collectionCollectionView.dataSource = self
        collectionCollectionView.delegate = self
        setupViews()
    }

    private func setupViews() {
        view.addSubview(stackImage)
        view.addSubview(titleLable)
        view.addSubview(authorLable)
        view.addSubview(descriptionLable)
        view.addSubview(authorButton)
        view.addSubview(collectionCollectionView)


        NSLayoutConstraint.activate([
            stackImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            stackImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackImage.heightAnchor.constraint(equalToConstant: 310)
        ])

        stackImage.addArrangedSubview(imageCellFirst)
        stackImage.addArrangedSubview(imageCellSecond)
        stackImage.addArrangedSubview(imageCellThird)

        NSLayoutConstraint.activate([
            imageCellFirst.heightAnchor.constraint(equalToConstant: 310),
            imageCellSecond.heightAnchor.constraint(equalToConstant: 310),
            imageCellThird.heightAnchor.constraint(equalToConstant: 310)
        ])
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: stackImage.bottomAnchor, constant: 16),
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
            collectionCollectionView.topAnchor.constraint(equalTo: descriptionLable.bottomAnchor, constant: 24),
            collectionCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            collectionCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            collectionCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }

    @objc
    func didAuthorButton() {
    }
    
}// end CollectionViewController

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem * 1.8

        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
