//
//  TextField.swift
//  FakeNFT
//
//  Created by Artem Novikov on 06.10.2023.
//

import UIKit

// MARK: - TextField
final class TextField: UITextField {

    // MARK: - Public Properties
    let padding: UIEdgeInsets

    // MARK: - Initializers
    init(
        cornerRadius: CGFloat = 12,
        padding: UIEdgeInsets = UIEdgeInsets(top: 11, left: 16, bottom: 11, right: 40)
    ) {
        self.padding = padding
        super.init(frame: .zero)
        backgroundColor = A.Colors.lightGrayDynamic.color
        textColor = A.Colors.blackDynamic.color
        font = .regular17
        layer.cornerRadius = cornerRadius
        clearButtonMode = .whileEditing
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overridden Methods
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let originalRect = super.clearButtonRect(forBounds: bounds)
        return originalRect.offsetBy(dx: -10, dy: 0)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}
