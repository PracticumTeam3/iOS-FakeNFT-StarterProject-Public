//
//  MyNFTView.swift
//  FakeNFT
//
//  Created by Artem Novikov on 11.10.2023.
//

import UIKit

// MARK: - MyNFTView
final class MyNFTView: UIView {

    // MARK: - Public properties
    enum State {
        case empty
        case standart
    }

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = A.Colors.whiteDynamic.color
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.register(MyNFTTableViewCell.self)
        return tableView
    }()

    // MARK: - Private properties
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = A.Colors.blackDynamic.color
        label.font = .bold17
        label.text = L.Profile.MyNFT.empty
        label.textAlignment = .center
        return label
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    func changeState(_ state: State) {
        switch state {
        case .empty:
            emptyLabel.isHidden = false
            tableView.isHidden = true
        case .standart:
            emptyLabel.isHidden = true
            tableView.isHidden = false
        }
    }

    // MARK: - Private methods
    private func setupUI() {
        backgroundColor = A.Colors.whiteDynamic.color
        emptyLabel.isHidden = true
    }

    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emptyLabel)

        NSLayoutConstraint.activate([
            emptyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            emptyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}