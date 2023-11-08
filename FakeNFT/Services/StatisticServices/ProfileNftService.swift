//
//  ProfileNftService.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 06.11.2023.
//

import Foundation

final class ProfileNftService {
    // MARK: - Private properties
    private var request = GetProfileRequest()
    private let networkClient = DefaultNetworkClient()
    
    // MARK: - Public properties
    static let shared = ProfileNftService()
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Public methods
    func fetchProfile(completion: @escaping(Result<ProfileNftsModel, Error>) -> Void) {
        networkClient.send(request: request, type: ProfileNftsModel.self) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func putProfileNFT(model: ProfileNftsModel,
                       completion: @escaping(Result<ProfileNftsModel, Error>) -> Void) {
        let request = PutNftsRequest(model: model)
        networkClient.send(request: request, type: ProfileNftsModel.self) { result in
            switch result {
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
