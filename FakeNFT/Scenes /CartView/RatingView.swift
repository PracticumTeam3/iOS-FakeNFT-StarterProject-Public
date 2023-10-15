//
//  RatingView.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 10.10.2023.
//

import UIKit

final class RatingView: UIView {
    private let rating: Int
    private let horizontalStack = UIStackView()
    private var imageViewArray = [UIImageView]()
    init(rating: Int) {
        self.rating = rating
        super .init(frame: CGRect())
//        self.backgroundColor = .yellow
        layoutSupport()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutSupport() {
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = 2
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
            self.widthAnchor.constraint(equalToConstant: 68),
            self.heightAnchor.constraint(equalToConstant: 12),
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
