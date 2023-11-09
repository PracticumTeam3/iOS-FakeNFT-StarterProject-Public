//
//  RefreshControl.swift
//  FakeNFT
//
//  Created by Artem Novikov on 24.10.2023.
//

import UIKit

// MARK: - RefreshControl
final class RefreshControl: UIRefreshControl {

    override init() {
        super.init()
        attributedTitle = NSAttributedString(
            string: L.ptr,
            attributes: [
                .foregroundColor: A.Colors.blackDynamic.color,
                .font: UIFont.Regular.small
            ]
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
