//
//  ProfileListViewModel.swift
//  FakeNFT
//
//  Created by Andrey Ovchinnikov on 24.10.2023.
//

import Foundation

protocol ProfileListViewModelProtocol {
    var profiles: [ProfileResult] { get }
    var onChange: (() -> Void)? { get set }
    func fetchProfiles(completion: @escaping() -> Void)
    func sortProfilesByName()
    func sortProfilesByRating()
    func numberOfRows() -> Int
    func cellViewModel(at indexPath: IndexPath) -> ProfileCellViewModelProtocol
}

final class ProfileListViewModel: ProfileListViewModelProtocol {
    // MARK: - Public properties
    var onChange: (() -> Void)?
    var profiles: [ProfileResult] = [] {
        didSet {
            onChange?()
        }
    }
    let request = GetProfilesRequest()
    let networkClient = DefaultNetworkClient()
    
    // MARK: - Public methods
    func fetchProfiles(completion: @escaping() -> Void) {
        networkClient.send(
            request: request,
            type: [ProfileResult].self) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.profiles = data
                    completion()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func numberOfRows() -> Int {
        profiles.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ProfileCellViewModelProtocol {
        return ProfileCellViewModel(profile: profiles[indexPath.row], indexPath: indexPath)
    }
    
    func sortProfilesByName() {
        let sortProfiles = profiles.sorted { $0.name < $1.name }
        profiles = sortProfiles
    }
    
    func sortProfilesByRating() {
        let sortProfiles = profiles.sorted { Int($0.rating) ?? 0 > Int($1.rating) ?? 0 }
        profiles = sortProfiles
    }
}
