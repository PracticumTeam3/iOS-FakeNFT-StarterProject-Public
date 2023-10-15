//
//  NftDeleteAlert.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 11.10.2023.
//

import UIKit

protocol NfyDeleteAlertDelegateProtocol {
    func deleteNft(index: Int)
}

final class NftDeleteAlert: UIViewController {
    var delegate:NfyDeleteAlertDelegateProtocol?
    var index: Int
    private let alertImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .regular13
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = L.Cart.deleteQuestion
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = A.Colors.blackDynamic.color
        button.setTitle(L.Cart.delete, for: .normal)
        button.setTitleColor(A.Colors.red.color, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let returnButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = A.Colors.blackDynamic.color
        button.setTitle(L.Cart.return, for: .normal)
        button.setTitleColor(A.Colors.whiteDynamic.color, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    init(image:UIImage, index: Int){
        self.alertImage.image = image
        self.index = index
        super .init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        deleteButton.addTarget(self, action: #selector(pressedDelete), for: .touchUpInside)
        returnButton.addTarget(self, action: #selector(pressedReturn), for: .touchUpInside)
        backgroudViewSupport()
        view.addSubview(alertImage)
        view.addSubview(questionLabel)
        view.addSubview(deleteButton)
        view.addSubview(returnButton)
        layoutSupport()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        additionalSafeAreaInsets = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }
    private func backgroudViewSupport(){
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    private func layoutSupport(){
        NSLayoutConstraint.activate([
            alertImage.widthAnchor.constraint(equalToConstant: 108),
            alertImage.heightAnchor.constraint(equalToConstant: 108),
            alertImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            alertImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 244)
        ])
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: alertImage.bottomAnchor, constant: 12)
        ])
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: 127),
            deleteButton.heightAnchor.constraint(equalToConstant: 44),
            deleteButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -4),
            deleteButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            returnButton.widthAnchor.constraint(equalToConstant: 127),
            returnButton.heightAnchor.constraint(equalToConstant: 44),
            returnButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 4),
            returnButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20)
        ])
    }
    @objc
    private func pressedDelete(){
        delegate?.deleteNft(index: index)
        dismiss(animated: false)
    }
    @objc
    private func pressedReturn(){
        dismiss(animated: false)
    }
}
