//
//  RatingBarView.swift
//  FakeNFT
//
//  Created by Алиса Долматова on 31.10.2023.
//

import Foundation
import UIKit

class RatingBarView:UIStackView {

   init(rating: Int, totalStars: Int = 5) {
       super.init(frame: .zero)
       axis = .horizontal
       distribution = .fillProportionally
       spacing = 2
        let activeStarImage = UIImage(named: "activeStar")
        let inactiveStarImage = UIImage(named: "inactiveStar")

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
