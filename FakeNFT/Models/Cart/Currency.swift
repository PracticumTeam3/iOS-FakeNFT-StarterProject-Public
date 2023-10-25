//
//  Currency.swift
//  FakeNFT
//
//  Created by Александр Кудряшов on 25.10.2023.
//

import Foundation

struct Currency {
    var title: String
    var name: String
    var image: URL
    var id: String
    init(title: String, name: String, image: String, id: String) {
        self.title = title
        self.name = name
        self.image = URL(string: image)!
        self.id = id
    }
}
