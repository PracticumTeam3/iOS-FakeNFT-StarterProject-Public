//
//  EditProfileLabel.swift
//  FakeNFT
//
//  Created by Artem Novikov on 06.10.2023.
//

import UIKit

// MARK: - EditProfileLabel
final class EditProfileLabel: UILabel {

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .bold22
        textColor = A.Colors.blackDynamic.color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
