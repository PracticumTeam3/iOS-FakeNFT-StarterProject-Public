//
//  PaymentCollectionCell.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 18.10.2023.
//

import UIKit
import Kingfisher

final class PaymentCollectionCell: UICollectionViewCell, ReuseIdentifying {
    
    static var defaultReuseIdentifier: String  = "PaymentCollectionCell"
    
    var viewModel: PaymentCellViewModel! {
        didSet {
            coinImageView.kf.setImage(with: viewModel.imageURL)
            coinNameLabel.text = viewModel.coinName
            coinShortNameLabel.text = viewModel.coinShortName
        }
    }
    
    private let coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.backgroundColor = A.Colors.blackDynamic.color
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let coinNameLabel: UILabel = {
        let label = UILabel()
        label.font = .regular13
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coinShortNameLabel: UILabel = {
        let label = UILabel()
        label.font = .regular13
        label.textColor = A.Colors.green.color
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: CGRect())
        cellSupport()
        layoutSupport()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutSupport() {
        self.addSubview(coinImageView)
        self.addSubview(coinNameLabel)
        self.addSubview(coinShortNameLabel)
        
        NSLayoutConstraint.activate([
            coinImageView.widthAnchor.constraint(equalToConstant: 36),
            coinImageView.heightAnchor.constraint(equalToConstant: 36),
            coinImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12)
        ])
        NSLayoutConstraint.activate([
            coinNameLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            coinNameLabel.leftAnchor.constraint(equalTo: coinImageView.rightAnchor, constant: 4)
        ])
        NSLayoutConstraint.activate([
            coinShortNameLabel.topAnchor.constraint(equalTo: self.centerYAnchor),
            coinShortNameLabel.leftAnchor.constraint(equalTo: coinImageView.rightAnchor, constant: 4)
        ])
    }
    
    private func cellSupport() {
        self.backgroundColor = A.Colors.lightGrayDynamic.color
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12
    }
}
