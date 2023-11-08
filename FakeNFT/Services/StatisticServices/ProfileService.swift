//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 01.11.2023.
//

import Foundation

final class ProfileService {
    // MARK: - Private properties
    private let request = GetUsersRequest()
    private let networkClient = DefaultNetworkClient()
    
    // MARK: - Public properties
    static let shared = ProfileService()
    
    // MARK: - Initializers
    private init() {}
     
    // MARK: - Public methods
    func fetchProfiles(completion: @escaping(Result<[ProfileResult], Error>) -> Void) {
        networkClient.send(
            request: request,
            type: [ProfileResult].self) { result in
                switch result {
                case .success(let profiles):
                    completion(.success(profiles))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
