//
//  PaymentViewController.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 18.10.2023.
//

import UIKit
import ProgressHUD

final class PaymentViewController: UIViewController {
    
    private enum Constants {
        enum CollectionView {
            static let topInset: CGFloat = 20
            static let leftInset: CGFloat = 16
            static let bottomInset: CGFloat = 16
            static let rightInset: CGFloat = 16
            static let minimumSpacing: CGFloat = 7
        }
        enum Cell {
            static let height: CGFloat = 46
            static let selectBorderWidth: CGFloat = 1
            static let deselectBorderWidth: CGFloat = 0
        }
        enum TermsOfUseView {
            static let cornerRadius: CGFloat = 12
            static let height: CGFloat = 186
        }
        enum PayButton {
            static let cornerRadius: CGFloat = 16
            static let leftInset: CGFloat = 16
            static let rightInset: CGFloat = 16
            static let height: CGFloat = 60
            static let bottomInset: CGFloat = 50
        }
        enum TermsOfUseLabel {
            static let topInset: CGFloat = 16
            static let leftInset: CGFloat = 16
            static let rightInset: CGFloat = 16
        }
        enum TermsOfUseButton {
            static let leftInset: CGFloat = 16
        }
    }
    
    private let viewModel: PaymentViewViewModel
    private let alertPresenter = AlertPresenter()
    
    private let termsOfUseView: UIView = {
        let view = UIView()
        view.backgroundColor = A.Colors.lightGrayDynamic.color
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Constants.TermsOfUseView.cornerRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let termsOfUseLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .Regular.small
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .left
        label.text = L.Cart.userAgreementStart
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var termsOfUseButton: UIButton = {
        let button = UIButton()
        button.setTitle(L.Cart.userAgreementEnd, for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(A.Colors.blue.color, for: .normal)
        button.titleLabel?.font = .Regular.small
        button.addTarget(self, action: #selector(termsOfUsePressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = A.Colors.blackDynamic.color
        button.setTitle(L.Cart.pay, for: .normal)
        button.titleLabel?.font = .Bold.small
        button.setTitleColor(A.Colors.whiteDynamic.color, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.PayButton.cornerRadius
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PaymentCollectionCell.self)
        collectionView.backgroundColor = A.Colors.whiteDynamic.color
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
        
    init(viewModel: PaymentViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSupport()
        view.addSubview(collectionView)
        view.addSubview(termsOfUseView)
        termsOfUseView.addSubview(payButton)
        termsOfUseView.addSubview(termsOfUseLabel)
        termsOfUseView.addSubview(termsOfUseButton)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        bind()
        buttonIsActivate(viewModel.isSelectedCoin)
    
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: termsOfUseView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            termsOfUseView.heightAnchor.constraint(equalToConstant: Constants.TermsOfUseView.height),
            termsOfUseView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            termsOfUseView.leftAnchor.constraint(equalTo: view.leftAnchor),
            termsOfUseView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            payButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                            constant: Constants.PayButton.leftInset),
            payButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                             constant: -Constants.PayButton.rightInset),
            payButton.heightAnchor.constraint(equalToConstant: Constants.PayButton.height),
            payButton.bottomAnchor.constraint(equalTo: termsOfUseView.bottomAnchor,
                                              constant: -Constants.PayButton.bottomInset),
            payButton.centerXAnchor.constraint(equalTo: termsOfUseView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            termsOfUseLabel.topAnchor.constraint(equalTo: termsOfUseView.topAnchor,
                                                 constant: Constants.TermsOfUseLabel.topInset),
            termsOfUseLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                  constant: Constants.TermsOfUseLabel.leftInset),
            termsOfUseLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
                                                   constant: -Constants.TermsOfUseLabel.rightInset)
        ])
        
        NSLayoutConstraint.activate([
            termsOfUseButton.topAnchor.constraint(equalTo: termsOfUseLabel.bottomAnchor),
            termsOfUseButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
                                                   constant: Constants.TermsOfUseButton.leftInset)
        ])
  
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressHUD(viewModel.progressHUDIsActive)
        showNetWorkAlert(viewModel.showNetWorkError)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
    
    private func viewSupport() {
        view.backgroundColor = A.Colors.whiteDynamic.color
        navigationItem.title = L.Cart.choosePay
        let leftBarButtom = UIBarButtonItem(image: A.Icons.back.image,
                                            style: .done,
                                            target: self,
                                            action: #selector(backVC))
        leftBarButtom.tintColor = A.Colors.blackDynamic.color
        navigationItem.leftBarButtonItem = leftBarButtom
    }
    
    @objc
    func backVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func termsOfUsePressed() {
        let webViewModel = CartWebViewModel()
        let webVC = CartWebViewController(viewModel: webViewModel)
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    @objc
    func pressedButton() {
        viewModel.pressPay { [weak self] result in
            switch result {
            case .success(let isSuccess):
                if isSuccess {
                    DispatchQueue.main.async {
                        self?.showSuccessVC()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.showAlert()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showNetWorkAlert(true)
                }
                print(error.localizedDescription)
            }
        }
    }
    
    private func showSuccessVC() {
        let vc = SuccessPayViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: L.Cart.failurePay,
                                      message: nil,
                                      preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: L.Cart.cancel,
                                    style: .default)
        let actionRepeat = UIAlertAction(title: L.Cart.repeat,
                                         style: .default) { [weak self] _ in
            self?.pressedButton()
        }
        alert.addAction(actionCancel)
        alert.addAction(actionRepeat)
        alert.preferredAction = actionRepeat
        self.present(alert, animated: true)
    }
    
    private func bind() {
        viewModel.$coins.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        viewModel.$isSelectedCoin.bind { [weak self] coinIsSelected in
            DispatchQueue.main.async {
                self?.buttonIsActivate(coinIsSelected)
            }
        }
        viewModel.$progressHUDIsActive.bind { [weak self] isShow in
            DispatchQueue.main.async {
                self?.progressHUD(isShow)
            }
        }
        viewModel.$showNetWorkError.bind { [weak self] isShow in
            DispatchQueue.main.async {
                self?.showNetWorkAlert(isShow)
            }
        }
    }
    
    private func progressHUD(_ isShow: Bool) {
        if isShow {
            ProgressHUD.show()
        } else {
            ProgressHUD.dismiss()
        }
    }
    
    private func showNetWorkAlert(_ isShow: Bool?) {
        if isShow == true {
            alertPresenter.showNetworkAlert(viewController: self) {
                self.viewModel.fetchCoins()
            }
        }
    }
    
    private func buttonIsActivate(_ activate: Bool) {
        if activate {
            payButton.isEnabled = true
            payButton.backgroundColor = A.Colors.blackDynamic.color
        } else {
            payButton.isEnabled = false
            payButton.backgroundColor = A.Colors.blackDynamic.color.withAlphaComponent(0.5)
        }
    }
    
}

// MARK: - Extension UICollectionViewDataSource
extension PaymentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.coins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PaymentCollectionCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        let cellViewModel = viewModel.coins[indexPath.row]
        cell.viewModel = cellViewModel
        if cell.viewModel.id == viewModel.selectedCoin {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
        }
        return cell
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout
extension PaymentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PaymentCollectionCell
        else { return }
        viewModel.changeSelectedCoin(id: cell.viewModel.id)
        cell.layer.borderColor = A.Colors.blackDynamic.color.cgColor
        cell.layer.borderWidth = Constants.Cell.selectBorderWidth
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PaymentCollectionCell
        else { return }
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.borderWidth = Constants.Cell.deselectBorderWidth
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.CollectionView.topInset,
                            left: Constants.CollectionView.leftInset,
                            bottom: Constants.CollectionView.bottomInset,
                            right: Constants.CollectionView.rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width -
                              Constants.CollectionView.leftInset -
                              Constants.CollectionView.rightInset -
                              Constants.CollectionView.minimumSpacing)/2,
                      height: Constants.Cell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.CollectionView.minimumSpacing
    }
    
}
