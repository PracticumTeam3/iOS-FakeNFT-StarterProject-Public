//
//  NftDeleteAlert.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 11.10.2023.
//

import UIKit

protocol NfyDeleteAlertDelegate: AnyObject {
    func deleteNft(id: String)
}

final class NftDeleteAlert: UIViewController {
    
    private enum Constants {
        enum SafeArea {
            static let topInset: CGFloat = 20
            static let leftInset: CGFloat = 0
            static let bottonInset: CGFloat = 0
            static let rightInset: CGFloat = 0
        }
        enum AlertImage {
            static let cornerRadius: CGFloat = 12
            static let width: CGFloat = 108
            static let height: CGFloat = 108
            static let topInset: CGFloat = 244
        }
        enum QuestionLabel {
            static let bottomInset: CGFloat = 12
        }
        enum DeleteButton {
            static let cornerRadius: CGFloat = 12
            static let width: CGFloat = 127
            static let height: CGFloat = 44
            static let rightInset: CGFloat = 4
            static let topInset: CGFloat = 20
        }
        enum ReturnButton {
            static let cornerRadius: CGFloat = 12
            static let width: CGFloat = 127
            static let height: CGFloat = 44
            static let leftInset: CGFloat = 4
            static let topInset: CGFloat = 20
        }
    }
    
    weak var delegate:NfyDeleteAlertDelegate?
    var id: String
    private let alertImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.AlertImage.cornerRadius
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .Regular.small
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
        button.layer.cornerRadius = Constants.DeleteButton.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let returnButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = A.Colors.blackDynamic.color
        button.setTitle(L.Cart.return, for: .normal)
        button.setTitleColor(A.Colors.whiteDynamic.color, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.ReturnButton.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(image:UIImage, id: String) {
        self.alertImage.image = image
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
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
        additionalSafeAreaInsets = UIEdgeInsets(top: -Constants.SafeArea.topInset,
                                                left: Constants.SafeArea.leftInset,
                                                bottom: Constants.SafeArea.bottonInset,
                                                right: Constants.SafeArea.rightInset)
    }
    
    private func backgroudViewSupport() {
        var blurEffect = UIBlurEffect()
        if traitCollection.userInterfaceStyle == .dark {
            blurEffect = UIBlurEffect(style: .dark)
        } else {
            blurEffect = UIBlurEffect(style: .light)
        }
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    private func layoutSupport() {
        NSLayoutConstraint.activate([
            alertImage.widthAnchor.constraint(equalToConstant: Constants.AlertImage.width),
            alertImage.heightAnchor.constraint(equalToConstant: Constants.AlertImage.height),
            alertImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            alertImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: Constants.AlertImage.topInset)
        ])
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: alertImage.bottomAnchor,
                                               constant: Constants.QuestionLabel.bottomInset)
        ])
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: Constants.DeleteButton.width),
            deleteButton.heightAnchor.constraint(equalToConstant: Constants.DeleteButton.height),
            deleteButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                                constant: -Constants.DeleteButton.rightInset),
            deleteButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor,
                                              constant: Constants.DeleteButton.topInset)
        ])
        NSLayoutConstraint.activate([
            returnButton.widthAnchor.constraint(equalToConstant: Constants.ReturnButton.width),
            returnButton.heightAnchor.constraint(equalToConstant: Constants.ReturnButton.height),
            returnButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor,
                                               constant: Constants.ReturnButton.leftInset),
            returnButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor,
                                              constant: Constants.ReturnButton.topInset)
        ])
    }
    
    @objc
    private func pressedDelete() {
        delegate?.deleteNft(id: id)
        dismiss(animated: false)
    }
    
    @objc
    private func pressedReturn() {
        dismiss(animated: false)
    }
}
