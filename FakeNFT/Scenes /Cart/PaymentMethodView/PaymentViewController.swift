//
//  PaymentViewController.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 18.10.2023.
//

import UIKit

final class PaymentViewController: UIViewController {
    
    private let viewModel: PaymentViewViewModel
    
    private let termsOfUseView: UIView = {
        let view = UIView()
        view.backgroundColor = A.Colors.lightGrayDynamic.color
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let termsOfUseLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .regular13
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
        button.titleLabel?.font = .regular13
        button.addTarget(self, action: #selector(termsOfUsePressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = A.Colors.blackDynamic.color
        button.setTitle(L.Cart.pay, for: .normal)
        button.setTitleColor(A.Colors.whiteDynamic.color, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PaymentCollectionCell.self)
        collectionView.backgroundColor = A.Colors.whiteDynamic.color
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
        
    init(viewModel: PaymentViewViewModel) {
        self.viewModel = viewModel
        super .init(nibName: nil, bundle: nil)
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
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            termsOfUseView.heightAnchor.constraint(equalToConstant: 186),
            termsOfUseView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            termsOfUseView.leftAnchor.constraint(equalTo: view.leftAnchor),
            termsOfUseView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            payButton.widthAnchor.constraint(equalTo: termsOfUseView.widthAnchor, constant: -32),
            payButton.heightAnchor.constraint(equalToConstant: 60),
            payButton.bottomAnchor.constraint(equalTo: termsOfUseView.bottomAnchor, constant: -50),
            payButton.centerXAnchor.constraint(equalTo: termsOfUseView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            termsOfUseLabel.topAnchor.constraint(equalTo: termsOfUseView.topAnchor, constant: 16),
            termsOfUseLabel.leftAnchor.constraint(equalTo: termsOfUseView.leftAnchor, constant: 16),
            termsOfUseLabel.rightAnchor.constraint(equalTo: termsOfUseView.rightAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            termsOfUseButton.topAnchor.constraint(equalTo: termsOfUseLabel.bottomAnchor),
            termsOfUseButton.leftAnchor.constraint(equalTo: termsOfUseLabel.leftAnchor)
        ])
  
    }
    
    private func viewSupport() {
        view.backgroundColor = A.Colors.whiteDynamic.color
        navigationItem.title = L.Cart.choosePay
        let leftBarButtom = UIBarButtonItem(image: A.Icons.backward.image,
                                            style: .done,
                                            target: self,
                                            action: #selector(backVC))
        leftBarButtom.tintColor = A.Colors.blackDynamic.color
        navigationItem.leftBarButtonItem = leftBarButtom
    }
    
    @objc
    func backVC() {
        self.dismiss(animated: true)
    }
    
    @objc
    func termsOfUsePressed() {
        // TODO: Open WebView
    }
    
    @objc
    func pressedButton() {
        // TODO: NextRewiew
    }
    
    private func bind() {
        viewModel.$coins.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }
        viewModel.$isSelectedCoin.bind { [weak self] coinIsSelected in
            self?.buttonIsActivate(coinIsSelected)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentCollectionCell.defaultReuseIdentifier, for: indexPath) as?  PaymentCollectionCell
        else { return UICollectionViewCell()}
        let cellViewModel = viewModel.coins[indexPath.row]
        cell.viewModel = cellViewModel
        return cell
    }
}

// MARK: - Extension UICollectionViewDelegateFlowLayout
extension PaymentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PaymentCollectionCell
        else { return }
        viewModel.changeSelectedCoin(index: indexPath.row)
        cell.layer.borderColor = A.Colors.blackDynamic.color.cgColor
        cell.layer.borderWidth = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PaymentCollectionCell
        else { return }
        cell.layer.borderWidth = 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 39)/2, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
}
