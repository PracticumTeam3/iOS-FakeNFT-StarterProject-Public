//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 19.10.2023.
//

import Foundation
import UIKit
// swiftlint:disable trailing_whitespace
final class CatalogViewController: UIViewController {

    let catalogTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(CatalogCell.self, forCellReuseIdentifier: "catalogCell")
        table.backgroundColor = .white
        table.estimatedRowHeight = 44.0
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        catalogTableView.dataSource = self
        catalogTableView.delegate = self
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "sort"), style: .plain, target: self, action: #selector(didTapSortButton))
        view.addSubview(catalogTableView)
        
        NSLayoutConstraint.activate([
            catalogTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            catalogTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            catalogTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            catalogTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        ])
    }
    
    @objc
    func didTapSortButton() {
        let alertController = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)

        let sortByTitleAction = UIAlertAction(title: "По названию", style: .default) { _ in
            // код для сортировки по названию
        }

        let sortByQuantityAction = UIAlertAction(title: "По количеству NFT", style: .default) { _ in
            // код для сортировки по количеству NFT
        }

        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel, handler: nil)

        alertController.addAction(sortByTitleAction)
        alertController.addAction(sortByQuantityAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
    
} // end CatalogViewController

extension CatalogViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catalogCell", for: indexPath)
        cell.contentView.layer.cornerRadius = 12
        cell.contentView.clipsToBounds = true
        return cell
    }
}

extension CatalogViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let collectionVC = CollectionViewController()
        self.navigationController?.pushViewController(collectionVC, animated: true)
    }
}
