//
//  CatalogCell.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 19.10.2023.
//

import UIKit
import Kingfisher

// swiftlint:disable trailing_whitespace
class CatalogCell:UITableViewCell {
    let imageCell: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()

    let lableCell: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = UIColor(named:A.Colors.black.name)
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
        viewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        viewCell.addSubview(imageCell)
        viewCell.addSubview(lableCell)
        NSLayoutConstraint.activate([
            imageCell.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 0),
            imageCell.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: 0),
            imageCell.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant: 0),
            imageCell.heightAnchor.constraint(equalToConstant: 140)
        ])
        NSLayoutConstraint.activate([
            lableCell.topAnchor.constraint(equalTo: imageCell.bottomAnchor, constant: 4),
            lableCell.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 0),
            lableCell.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: -13)
        ])
    }

    func setData(catalogCellData: CatalogCellModel) {
        if let image = catalogCellData.imageCollection.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
            let url = URL(string: image)
            imageCell.kf.setImage(with:url)
        }

        lableCell.text = "\(catalogCellData.collectionName) (\(catalogCellData.nftCount))"
    }
    
} // end CatalogCell
