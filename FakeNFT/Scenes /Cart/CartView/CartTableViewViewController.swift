//
//  CartTableViewViewController.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit
import ProgressHUD

final class CartTableViewViewController: UIViewController {
    
    private let viewModel: CartTableViewViewModel
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = .bold17
        label.textAlignment = .center
        label.textColor = A.Colors.blackDynamic.color
        label.text = L.Cart.cartEmpty
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nftTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartTableViewCell.self)
        tableView.isScrollEnabled = true
        tableView.backgroundColor = A.Colors.whiteDynamic.color
        tableView.allowsMultipleSelection = false
        tableView.alwaysBounceVertical = true
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let cartView: UIView = {
        let view = UIView()
        view.backgroundColor = A.Colors.lightGrayDynamic.color
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let countNFTLabel: UILabel = {
        let label = UILabel()
        label.font = .regular15
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
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
        button.titleLabel?.font = .bold17
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressHUD(viewModel.progressHUDIsActive)
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
            nftTableView.bottomAnchor.constraint(equalTo: cartView.topAnchor)
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
            DispatchQueue.main.async {
                self?.nftTableView.reloadData()
            }
        }
        viewModel.$nftCount.bind { [weak self] newCount in
            DispatchQueue.main.async {
                self?.countNFTLabel.text = newCount
            }
        }
        viewModel.$nftPrices.bind { [weak self] newPrice in
            DispatchQueue.main.async {
                self?.priceLabel.text = newPrice
            }
        }
        viewModel.$nftIsEmpty.bind { [weak self] newIsEmpty in
            DispatchQueue.main.async {
                self?.tableViewIsEmpty(newIsEmpty)
            }
        }
        viewModel.$progressHUDIsActive.bind { [weak self] isShow in
            DispatchQueue.main.async {
                self?.progressHUD(isShow)
            }
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
    
    private func progressHUD(_ isShow: Bool) {
        if isShow {
            ProgressHUD.show()
        } else {
            ProgressHUD.dismiss()
        }
    }
    
    @objc
    private func sortedNFT() {
        showActionSheet()
    }
    
    private func showActionSheet() {
        let alert = UIAlertController(title: L.Cart.sorted,
                                      message: nil,
                                      preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: L.Cart.sortedByPrice,
                                    style: .default) { [weak self] _ in
            self?.viewModel.changeSortes(CartSortedStorage.price)
        }
        let action2 = UIAlertAction(title: L.Cart.sortedByRating,
                                    style: .default) { [weak self] _ in
            self?.viewModel.changeSortes(CartSortedStorage.rating)
        }
        let action3 = UIAlertAction(title: L.Cart.sortedByName,
                                    style: .default) { [weak self] _ in
            self?.viewModel.changeSortes(CartSortedStorage.name)
        }
        let action4 = UIAlertAction(title: L.Cart.sortedClose,
                                    style: .cancel,
                                    handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        self.present(alert, animated: true)
    }
    @objc
    private func payNFT() {
        let paymentViewModel = PaymentViewViewModel()
        let paymentVC = PaymentViewController(viewModel: paymentViewModel)
        paymentVC.modalPresentationStyle = .fullScreen
        paymentVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(paymentVC, animated: true)
    }
}

// MARK: - Extension UITableViewDataSource
extension CartTableViewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortedNFT.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CartTableViewCell = tableView.dequeueReusableCell()
        cell.selectionStyle = .none
        cell.viewModel = viewModel.sortedNFT[indexPath.row]
        cell.viewModel.delegate = viewModel
        return cell
    }
}

// MARK: - Extension CartTableViewViewModelDelegate
extension CartTableViewViewController: CartTableViewViewModelDelegate {
    func showVC(_ vc: UIViewController) {
        self.present(vc, animated: false)
    }
}
