//
//  EditProfileStackView.swift
//  FakeNFT
//
//  Created by Artem Novikov on 06.10.2023.
//

import UIKit

// MARK: - EditProfileStackView
final class EditProfileStackView: UIStackView {

    // MARK: - Initializers
    init(spacing: CGFloat, arrangedSubviews: [UIView]) {
        super.init(frame: .zero)
        self.spacing = spacing
        axis = .vertical
        distribution = .fillProportionally
        for subview in arrangedSubviews {
            addArrangedSubview(subview)
        }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
