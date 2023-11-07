//
//  LikeService.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 04.11.2023.
//

import Foundation

final class ProfileLikeService {
    // MARK: - Private properties
    private var request = GetProfileRequest()
    private let networkClient = DefaultNetworkClient()
    
    // MARK: - Public properties
    static let shared = ProfileLikeService()
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Public methods
    func fetchProfile(completion: @escaping(Result<ProfileLikesModel, Error>) -> Void) {
        networkClient.send(request: request, type: ProfileLikesModel.self) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func putProfileLikes(model: ProfileLikesModel,
                         completion: @escaping(Result<ProfileLikesModel, Error>) -> Void) {
        let request = PutLikesRequest(model: model)
        networkClient.send(request: request, type: ProfileLikesModel.self) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
