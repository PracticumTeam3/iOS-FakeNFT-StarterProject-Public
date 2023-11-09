//
//  CartTableViewViewController.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit
import ProgressHUD

final class CartTableViewViewController: UIViewController {

    private enum Constants {
        enum NftTableView {
            static let topInset: CGFloat = 20
        }
        enum CartView {
            static let cornerRadius: CGFloat = 12
            static let height: CGFloat = 76
        }
        enum CountNFTLabel {
            static let topInset: CGFloat = 16
            static let leftInset: CGFloat = 16
        }
        enum PriceLabel {
            static let leftInset: CGFloat = 16
            static let bottomInset: CGFloat = 16
        }
        enum PayButton {
            static let width: CGFloat = 240
            static let cornerRadius: CGFloat = 16
            static let topInset: CGFloat = 16
            static let rightInset: CGFloat = 16
            static let bottomInset: CGFloat = 16
        }
    }

    private let refreshControl = RefreshControl()

    private let viewModel: CartTableViewViewModel

    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = .Bold.small
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
        view.layer.cornerRadius = Constants.CartView.cornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let countNFTLabel: UILabel = {
        let label = UILabel()
        label.font = .Regular.medium
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .left
        label.numberOfLines = 1
        label.isHidden = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .Bold.small
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
        button.titleLabel?.font = .Bold.small
        button.setTitleColor(A.Colors.whiteDynamic.color, for: .normal)
        button.backgroundColor = A.Colors.blackDynamic.color
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.PayButton.cornerRadius
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
        super.init(nibName: nil, bundle: nil)
        refreshControl.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
        nftTableView.refreshControl = refreshControl
        viewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = A.Colors.whiteDynamic.color
        layoutSupport()
        bind()
        nftTableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressHUD(viewModel.progressHUDIsActive)
        showNetworkAlert(viewModel.showNetWorkError)
    }

    private func layoutSupport() {
        view.addSubview(emptyLabel)
        view.addSubview(nftTableView)
        view.addSubview(cartView)
        cartView.addSubview(countNFTLabel)
        cartView.addSubview(priceLabel)
        cartView.addSubview(payButton)
        nftTableView.addSubview(refreshControl)
        NSLayoutConstraint.activate([
            emptyLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            nftTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                              constant: Constants.NftTableView.topInset),
            nftTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            nftTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            nftTableView.bottomAnchor.constraint(equalTo: cartView.topAnchor)
        ])
        NSLayoutConstraint.activate([
            cartView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            cartView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            cartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cartView.heightAnchor.constraint(equalToConstant: Constants.CartView.height)
        ])
        NSLayoutConstraint.activate([
            countNFTLabel.topAnchor.constraint(equalTo: cartView.topAnchor,
                                               constant: Constants.CountNFTLabel.topInset),
            countNFTLabel.leftAnchor.constraint(equalTo: cartView.leftAnchor,
                                                constant: Constants.CountNFTLabel.leftInset),
            priceLabel.leftAnchor.constraint(equalTo: cartView.leftAnchor,
                                             constant: Constants.PriceLabel.leftInset),
            priceLabel.bottomAnchor.constraint(equalTo: cartView.bottomAnchor,
                                               constant: -Constants.PriceLabel.bottomInset),
            payButton.topAnchor.constraint(equalTo: cartView.topAnchor,
                                           constant: Constants.PayButton.topInset),
            payButton.rightAnchor.constraint(equalTo: cartView.rightAnchor,
                                             constant: -Constants.PayButton.rightInset),
            payButton.bottomAnchor.constraint(equalTo: cartView.bottomAnchor,
                                              constant: -Constants.PayButton.bottomInset),
            payButton.widthAnchor.constraint(equalToConstant: Constants.PayButton.width)
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
        viewModel.$showNetWorkError.bind { [weak self] isShow in
            DispatchQueue.main.async {
                self?.showNetworkAlert(isShow)
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
            tableViewIsEmpty(viewModel.nftIsEmpty)
        }
    }

    private func showNetworkAlert(_ isShow: Bool?) {
        if isShow == true {
            AlertPresenter.show(in: self, model: .cartNetworkError { [weak self] in
                self?.viewModel.fetchOrder()
            })
        }
    }

    @objc
    private func sortedNFT() {
        showActionSheet()
    }

    private func showActionSheet() {
        AlertPresenter.show(in: self, model: .sortActionSheet(
            priceCompletion: { [weak self] in
                self?.viewModel.changeSortes(CartSortedStorage.price)
            },
            ratingCompletion: { [weak self] in
                self?.viewModel.changeSortes(CartSortedStorage.rating)
            },
            nameCompletion: { [weak self] in
                self?.viewModel.changeSortes(CartSortedStorage.name)
            })
        )
    }

    @objc
    private func payNFT() {
        let paymentViewModel = PaymentViewViewModel()
        let paymentVC = PaymentViewController(viewModel: paymentViewModel)
        paymentVC.modalPresentationStyle = .fullScreen
        paymentVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(paymentVC, animated: true)
    }

    @objc
    private func reloadTableView() {
        viewModel.fetchOrder()
        refreshControl.endRefreshing()
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
