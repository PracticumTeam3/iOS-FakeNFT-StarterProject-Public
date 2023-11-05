//
//  MockServerConfig.swift
//  FakeNFTUITests
//
//  Created by Artem Novikov on 02.11.2023.
//

import Foundation

// MARK: - MockServerConfig
struct MockServerConfig {

    // MARK: - Public properties
    let method: HTTPMethod
    let path: String
    let json: Any

    enum HTTPMethod {
        case get
        case put
    }

    static let profile = MockServerConfig(
        method: .get,
        path: Endpoint.profile.path,
        json: encode(MockData.profile)
    )

    static let profileEmptyNFTs = MockServerConfig(
        method: .get,
        path: Endpoint.profile.path,
        json: encode(MockData.profileEmptyNFTs)
    )

    static let editProfile = MockServerConfig(
        method: .put,
        path: Endpoint.profile.path,
        json: encode(MockData.editedProfile)
    )

    static let profileUnlike: [MockServerConfig] = {
        var result: [MockServerConfig] = []
        for httpMethod in [HTTPMethod.get, HTTPMethod.put] {
            result.append(MockServerConfig(method: httpMethod,
                                           path: Endpoint.profile.path,
                                           json: encode(MockData.profileUnlike)))
        }
        return result
    }()

    static let nfts: [MockServerConfig] = {
        var result: [MockServerConfig] = []
        MockData.nftNetworkModels.forEach { nft in
            result.append(MockServerConfig(method: .get,
                                           path: Endpoint.nftById(id: nft.id).path,
                                           json: encode(nft)))
        }
        return result
    }()

    static let authors: [MockServerConfig] = {
        var result: [MockServerConfig] = []
        MockData.authors.forEach { author in
            result.append(MockServerConfig(method: .get,
                                           path: Endpoint.userById(id: author.id).path,
                                           json: encode(author)))
        }
        return result
    }()

    // MARK: - Private properties
    private static let jsonEncoder = JSONEncoder()

    // MARK: - Public methods
    private static func encode<T: Encodable>(_ model: T) -> Any {
        do {
            let jsonData = try jsonEncoder.encode(model)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            return jsonObject
        } catch {
            fatalError("Encoding failed with error: \(error)")
        }
    }

}
