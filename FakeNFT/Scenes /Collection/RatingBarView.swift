//
//  RatingBarView.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 31.10.2023.
//

import Foundation
import UIKit

final class RatingBarView:UIStackView {

   init(rating: Int, totalStars: Int = 5) {
       super.init(frame: .zero)
       axis = .horizontal
       distribution = .fillProportionally
       spacing = 2

       setData(rating: rating)
    }

    func setData(rating: Int, totalStars: Int = 5) {
        subviews.forEach { view in
            removeArrangedSubview(view)
        }

        let activeStarImage = UIImage(named: A.Icons.activeStar.name)
        let inactiveStarImage = UIImage(named: A.Icons.inactiveStar.name)

         for i in 0..<totalStars {
             let starImageView = UIImageView()

             if i < rating {
                 starImageView.image = activeStarImage
             } else {
                 starImageView.image = inactiveStarImage
             }

             starImageView.frame = CGRect(x: i * (16 + 2), y: 0, width: 16, height: 16)
             self.addArrangedSubview(starImageView)
         }
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
} // end RatingBarView
