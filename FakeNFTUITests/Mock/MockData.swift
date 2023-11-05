//
//  MockData.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 01.11.2023.
//

// swiftlint:disable line_length
enum MockData {

    static let profile = ProfileModel(
        name: "Name Surname",
        avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
        description: "Description",
        website: "https://practicum.yandex.ru/profile/ios-developer/",
        nfts: ["1", "2", "3"],
        likes: ["1", "2", "3"]
    )

    static let profileUnlike = ProfileModel(
        name: "Name Surname",
        avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
        description: "Description",
        website: "https://practicum.yandex.ru/profile/ios-developer/",
        nfts: ["1", "2", "3"],
        likes: ["2", "3"]
    )

    static let profileEmptyNFTs = ProfileModel(
        name: "Name Surname",
        avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
        description: "Description",
        website: "https://practicum.yandex.ru/profile/ios-developer/",
        nfts: [],
        likes: []
    )

    static let editedProfile = ProfileModel(
        name: "New Name",
        avatar: "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png",
        description: "New description",
        website: "https://ya.ru",
        nfts: ["1", "2", "3"],
        likes: ["1", "2", "3"]
    )

    static let myNFTModels: [NFTModel] = [
        NFTModel(image: "", name: "April", authorName: "Cole Edwards", rating: 5, price: 4.5),
        NFTModel(image: "", name: "Bethany", authorName: "Nicholas Flores", rating: 4, price: 2.28),
        NFTModel(image: "", name: "Grace", authorName: "Nicholas Flores", rating: 2, price: 6.12)
    ]

    static let favouriteNFTModels: [FavouriteNFTModel] = [
        FavouriteNFTModel(id: "", image: "", name: "April", rating: 5, price: 4.5),
        FavouriteNFTModel(id: "", image: "", name: "Bethany", rating: 4, price: 2.28),
        FavouriteNFTModel(id: "", image: "", name: "Grace", rating: 2, price: 6.12)
    ]

    static let nftNetworkModels: [NFTNetworkModel] = [
        NFTNetworkModel(
            createdAt: "2023-04-20T02:22:27Z",
            name: "April",
            images: [
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png",
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/2.png",
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/3.png"
            ],
            rating: 5,
            description: "A 3D model of a mythical creature.",
            price: 4.5,
            author: "1",
            id: "1"
        ),
        NFTNetworkModel(
            createdAt: "2023-04-20T02:22:27Z",
            name: "Bethany",
            images: [
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Bethany/1.png",
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Bethany/2.png",
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Bethany/3.png"
            ],
            rating: 4,
            description: "A digital collage of various memes.",
            price: 2.28,
            author: "2",
            id: "2"
        ),
        NFTNetworkModel(
            createdAt: "2023-04-20T02:22:27Z",
            name: "Grace",
            images: [
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Grace/1.png",
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Grace/2.png",
                "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Grace/3.png"
            ],
            rating: 2,
            description: "A vibrant illustration of a garden in bloom.",
            price: 6.12,
            author: "2",
            id: "3"
        )
    ]

    static let authors: [UserNetworkModel] = [
        UserNetworkModel(
            name: "Cole Edwards",
            avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/734.jpg",
            description: "Huge fan of the NFT space and its endless possibilities 🙌",
            website: "https://practicum.yandex.ru/middle-frontend/",
            nfts: [],
            rating: "72",
            id: "1"
        ),
        UserNetworkModel(
            name: "Nicholas Flores",
            avatar: "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/492.jpg",
            description: "The NFT world never ceases to amaze me 🤯",
            website: "https://practicum.yandex.ru/ycloud/",
            nfts: [],
            rating: "66",
            id: "2"
        )
    ]

}
