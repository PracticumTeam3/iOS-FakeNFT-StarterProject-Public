//
//  UsersService.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 01.11.2023.
//

import Foundation

final class UsersService {
    // MARK: - Private properties
    private let request = GetUsersRequest()
    private let networkClient = DefaultNetworkClient()

    // MARK: - Public properties
    static let shared = UsersService()

    // MARK: - Initializers
    private init() {}

    // MARK: - Public methods
    func fetchUsers(completion: @escaping(Result<[UserNetworkModel], Error>) -> Void) {
        networkClient.send(
            request: request,
            type: [UserNetworkModel].self) { result in
                switch result {
                case .success(let users):
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
