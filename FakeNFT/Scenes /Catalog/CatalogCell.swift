//
//  CatalogCell.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 19.10.2023.
//

import Foundation
import UIKit

// swiftlint:disable trailing_whitespace
class CatalogCell:UITableViewCell {
    let imageCellFirst: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let imageCellSecond: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let imageCellThird: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let stackImage: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 0
        stack.layer.cornerRadius = 12
        stack.layer.masksToBounds = true
        return stack
    }()

    let lableCell: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = UIColor(named: "black")
        lable.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        lable.textAlignment = .left
        lable.text = "нижний текст (11)"
        return lable
    }()

    let viewCell:UIView = {
       let cell = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        return cell
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(viewCell)
       NSLayoutConstraint.activate([

        viewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
        viewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
        viewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        viewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 4)
        ])
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        viewCell.addSubview(stackImage)
        viewCell.addSubview(lableCell)
        NSLayoutConstraint.activate([
            stackImage.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 0),
            stackImage.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: 0),
            stackImage.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant: 0),
            stackImage.heightAnchor.constraint(equalToConstant: 140)
        ])

        stackImage.addArrangedSubview(imageCellFirst)
        stackImage.addArrangedSubview(imageCellSecond)
        stackImage.addArrangedSubview(imageCellThird)

        NSLayoutConstraint.activate([
            imageCellFirst.heightAnchor.constraint(equalToConstant: 140),
            imageCellSecond.heightAnchor.constraint(equalToConstant: 140),
            imageCellThird.heightAnchor.constraint(equalToConstant: 140)
        ])

        NSLayoutConstraint.activate([
            lableCell.topAnchor.constraint(equalTo: stackImage.bottomAnchor, constant: 4),
            lableCell.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 0),
            lableCell.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: -13)
        ])
    }

    func setData(catalogCellData: CatalogCellModel) {
        imageCellFirst.image = catalogCellData.imageFirst
        imageCellSecond.image = catalogCellData.imageSecond
        imageCellThird.image = catalogCellData.imageThird
        lableCell.text = "\(catalogCellData.collectionName) (\(catalogCellData.nftCount))"
    }
    
} // end CatalogCell
