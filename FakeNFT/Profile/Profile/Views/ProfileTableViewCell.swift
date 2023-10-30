//
//  ProfileTableViewCell.swift
//  FakeNFT
//
//  Created by Artem Novikov on 05.10.2023.
//

import UIKit

// MARK: - ProfileTableViewCell
final class ProfileTableViewCell: UITableViewCell, ReuseIdentifying {

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        backgroundColor = A.Colors.whiteDynamic.color
        textLabel?.font = .Bold.small
        textLabel?.textColor = A.Colors.blackDynamic.color
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func configCell(label: String) {
        textLabel?.text = label
    }

}