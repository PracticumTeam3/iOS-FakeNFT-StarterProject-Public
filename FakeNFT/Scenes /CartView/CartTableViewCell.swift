//
//  CartTableViewCell.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 09.10.2023.
//

import UIKit

final class CartTableViewCell: UITableViewCell {
    private var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private var nftNameLabel: UILabel = {
        let label = UILabel()
        label.font = .bold17
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //TODO: Добавить imageView RAting
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .regular13
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .left
        label.text = L.Cart.price
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var nftPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .bold17
        label.textColor = A.Colors.blackDynamic.color
        label.textAlignment = .left
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var deletebutton: UIButton = {
        let button = UIButton()
        let image = A.Icons.deleteNft.image
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var viewModel: CartTableViewCellViewModel! {
        didSet {
            //TODO: Добавить вьюмодель
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nftImageView)
        contentView.addSubview(nftNameLabel)
        
        contentView.addSubview(priceLabel)
        contentView.addSubview(nftPriceLabel)
        contentView.addSubview(deletebutton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setRating(_ rating: Int) {
        
    }
}
