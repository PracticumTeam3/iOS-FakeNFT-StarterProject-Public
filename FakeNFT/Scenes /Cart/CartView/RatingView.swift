//
//  RatingView.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 10.10.2023.
//

import UIKit

final class RatingView: UIView {
    
    private enum Constants {
        static let width: CGFloat = 68
        static let height: CGFloat = 12
        static let spacing: CGFloat = 2
    }
    
    private let rating: Int
    private let horizontalStack = UIStackView()
    private var imageViewArray = [UIImageView]()
    
    init(rating: Int) {
        self.rating = rating
        super.init(frame: CGRect())
        layoutSupport()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutSupport() {
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = Constants.spacing
        for i in 1...5 {
            let imageView = UIImageView()
            if i <= rating {
                imageView.image = A.Icons.ratingOn.image
            } else {
                imageView.image = A.Icons.ratingOff.image
            }
            horizontalStack.addArrangedSubview(imageView)
            imageViewArray.append(imageView)
        }
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(horizontalStack)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: Constants.width),
            self.heightAnchor.constraint(equalToConstant: Constants.height),
            horizontalStack.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalStack.leftAnchor.constraint(equalTo: self.leftAnchor),
            horizontalStack.rightAnchor.constraint(equalTo: self.rightAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func updateRating(_ rating: Int) {
        var index = 0
        for imageView in imageViewArray {
            if index < rating {
                imageView.image = A.Icons.ratingOn.image
            } else {
                imageView.image = A.Icons.ratingOff.image
            }
            index += 1
        }
    }
}
