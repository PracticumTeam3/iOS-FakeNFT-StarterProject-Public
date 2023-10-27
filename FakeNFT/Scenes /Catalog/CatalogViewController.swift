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
    
    let sortButton: UIButton = {
        let sort = UIButton()
        let image = UIImage(named: "sort")
        sort.addTarget(CatalogViewController.self, action: #selector(Self.didTapSortButton), for: .touchUpInside)
        sort.translatesAutoresizingMaskIntoConstraints = false
        sort.setImage(image, for: .normal)
        return sort
    }()
    
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
        view.addSubview(sortButton)
        view.addSubview(catalogTableView)
        
        NSLayoutConstraint.activate([
            sortButton.heightAnchor.constraint(equalToConstant: 42),
            sortButton.widthAnchor.constraint(equalToConstant: 42),
            sortButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 9),
            sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            sortButton.bottomAnchor.constraint(equalTo: catalogTableView.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            catalogTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            catalogTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            catalogTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16)
        ])
    }
    
    @objc
    func didTapSortButton() {
        
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
}
