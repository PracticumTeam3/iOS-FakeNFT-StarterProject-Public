import Foundation

struct ProfileResult: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating: String
    let id: String
}

struct NFTModel: Codable {
    let images: [String]
    let name: String
    let rating: String
    let price: Float
}
