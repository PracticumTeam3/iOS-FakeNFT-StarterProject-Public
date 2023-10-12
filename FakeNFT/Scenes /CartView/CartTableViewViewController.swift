//
//  CartTableViewViewController.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit

final class CartTableViewViewController: UIViewController {
    private let viewModel: CartTableViewViewModel
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = .bold17
        label.textAlignment = .center
        label.textColor = A.Colors.blackDynamic.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var nftTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartTableViewCell.self)
        tableView.isScrollEnabled = true
        tableView.backgroundColor = A.Colors.whiteDynamic.color
        tableView.allowsMultipleSelection = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private var cartView: UIView = {
        let view = UIView()
        view.backgroundColor = A.Colors.lightGrayDynamic.color
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var countNFTLabel: UILabel = {
        let label = UILabel()
        label.font = .regular15
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .bold17
        label.textColor = A.Colors.green.color
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(payNFT), for: .touchUpInside)
        button.setTitle(L.Cart.toBePaid, for: .normal)
        button.setTitleColor(A.Colors.whiteDynamic.color, for: .normal)
        button.backgroundColor = A.Colors.blackDynamic.color
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: A.Icons.sort.image,
                                             style: .done,
                                             target: self,
                                             action: #selector(sortedNFT))
        button.tintColor = A.Colors.blackDynamic.color
        return button
    }()
    init(viewModel: CartTableViewViewModel = CartTableViewViewModel()) {
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = A.Colors.whiteDynamic.color
        tableViewIsEmpty(viewModel.nftIsEmpty)
        layoutSupport()
        bind()
        nftTableView.dataSource = self
        nftTableView.delegate = self
    }
    private func layoutSupport() {
        view.addSubview(emptyLabel)
        view.addSubview(nftTableView)
        view.addSubview(cartView)
        cartView.addSubview(countNFTLabel)
        cartView.addSubview(priceLabel)
        cartView.addSubview(payButton)
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            nftTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nftTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            nftTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            nftTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            cartView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            cartView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            cartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cartView.heightAnchor.constraint(equalToConstant: 76)
        ])
        NSLayoutConstraint.activate([
            countNFTLabel.topAnchor.constraint(equalTo: cartView.topAnchor, constant: 16),
            countNFTLabel.leftAnchor.constraint(equalTo: cartView.leftAnchor, constant: 16),
            priceLabel.leftAnchor.constraint(equalTo: cartView.leftAnchor, constant: 16),
            priceLabel.bottomAnchor.constraint(equalTo: cartView.bottomAnchor, constant: -16),
            payButton.topAnchor.constraint(equalTo: cartView.topAnchor, constant: 16),
            payButton.rightAnchor.constraint(equalTo: cartView.rightAnchor, constant: -16),
            payButton.bottomAnchor.constraint(equalTo: cartView.bottomAnchor, constant: -16),
            payButton.leftAnchor.constraint(equalTo: priceLabel.rightAnchor, constant: 24)
        ])
    }
    private func bind() {
        countNFTLabel.text = viewModel.nftCount
        priceLabel.text = viewModel.nftPrices
        viewModel.$sortedNFT.bind { [weak self] _ in
            self?.nftTableView.reloadData()
        }
        viewModel.$nftCount.bind { [weak self] newCount in
            self?.countNFTLabel.text = newCount
        }
        viewModel.$nftPrices.bind { [weak self] newPrice in
            self?.priceLabel.text = newPrice
        }
        viewModel.$nftIsEmpty.bind { [weak self] newIsEmpty in
            self?.tableViewIsEmpty(newIsEmpty)
        }
    }
    private func navigationSupport() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.topItem?.rightBarButtonItem = rightBarButton
    }
    private func tableViewIsEmpty(_ isEmpty: Bool) {
        nftTableView.isHidden = isEmpty
        cartView.isHidden = isEmpty
        emptyLabel.isHidden = !isEmpty
        if isEmpty {
            navigationItem.rightBarButtonItem = nil
        } else {
            navigationSupport()
        }
    }
    @objc
    private func sortedNFT(){
        //TODO: метод сортировки нфт
    }
    @objc
    private func payNFT() {
        //TODO: метод оплаты нфт
    }
}

//MARK: - Extension UITableViewDataSource
extension CartTableViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortedNFT.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = nftTableView.dequeueReusableCell(withIdentifier: CartTableViewCell.defaultReuseIdentifier, for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.viewModel = viewModel.sortedNFT[indexPath.row]
        cell.viewModel.delegate = viewModel
        cell.cellIndex = indexPath.row
        return cell
    }
}

//MARK: - Extension UITableViewDelegate
extension CartTableViewViewController: UITableViewDelegate {
    
}


//MARK: - Extension CartTableViewViewModelDelegateProtocol
extension CartTableViewViewController: CartTableViewViewModelDelegateProtocol {
    func showVC(_ vc: UIViewController) {
        self.present(vc, animated: false)
    }
}
