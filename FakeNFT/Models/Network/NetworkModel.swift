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

struct NFTResult: Codable {
    let name: String
    let rating: Int
    let price: Double
    let images: [String]
    let id: String
}
