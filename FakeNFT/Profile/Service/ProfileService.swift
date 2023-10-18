//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Artem Novikov on 09.10.2023.
//

import Foundation

// MARK: - ProfileServiceProtocol
protocol ProfileServiceProtocol {
    func fetchProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void)
    func editProfile(
        _ editProfileModel: EditProfileModel,
        completion: @escaping (Result<ProfileModel, Error>) -> Void
    )
    func getUser(
        id: String,
        completion: @escaping (Result<UserNetworkModel, Error>) -> Void
    )
    func getNFT(
        id: String,
        completion: @escaping (Result<NFTNetworkModel, Error>) -> Void
    )
    func getNFTs(completion: @escaping (Result<[NFTModel], Error>) -> Void)
}

// MARK: - ProfileService
struct ProfileService: ProfileServiceProtocol {

    // MARK: - Private properties
    private let networkClient: NetworkClient

    // MARK: - Initializers
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }

    // MARK: - Public methods
    func fetchProfile(completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        let request = GetProfileRequest()
        networkClient.send(request: request, type: ProfileModel.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func editProfile(
        _ editProfileModel: EditProfileModel,
        completion: @escaping (Result<ProfileModel, Error>) -> Void
    ) {
        let request = ChangeProfileRequest(model: editProfileModel)
        networkClient.send(request: request, type: ProfileModel.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getUser(
        id: String,
        completion: @escaping (Result<UserNetworkModel, Error>) -> Void
    ) {
        let userRequest = GetUserRequest(id: id)
        networkClient.send(request: userRequest, type: UserNetworkModel.self) { result in
            switch result {
            case .success(let userModel):
                completion(.success(userModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getNFT(
        id: String,
        completion: @escaping (Result<NFTNetworkModel, Error>) -> Void
    ) {
        let nftRequest = GetNFTRequest(id: id)
        networkClient.send(request: nftRequest, type: NFTNetworkModel.self) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getNFTs(completion: @escaping (Result<[NFTModel], Error>) -> Void) {
        guard let profile = UserDefaults.standard.profile else { return }
        var nfts: [NFTModel?] = Array(repeating: nil, count: profile.nfts.count)
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "load_nfts_queue")
        for (index, nftId) in profile.nfts.enumerated() {
            dispatchGroup.enter()
            getNFT(id: nftId) { result in
                switch result {
                case .success(let nftModel):
                    getUser(id: nftModel.author) { result in
                        switch result {
                        case .success(let userModel):
                            dispatchQueue.async {
                                nfts[index] = NFTModel(image: nftModel.images[0],
                                                       name: nftModel.name,
                                                       authorName: userModel.name,
                                                       rating: nftModel.rating,
                                                       price: nftModel.price)
                                dispatchGroup.leave()
                            }
                        case .failure(let error):
                            completion(.failure(error))
                            dispatchGroup.leave()
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: dispatchQueue) {
            completion(.success(nfts.compactMap { $0 }))
        }
    }

}
