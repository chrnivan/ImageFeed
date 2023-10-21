//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Ivan on 12.10.2023.
//

import Foundation

final class ProfileService {
    
    //MARK: - Private Properties
    static let shared = ProfileService()
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    private(set) var profile: Profile?
    
    // MARK: - Public Methods
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
        if profile != nil { return }
        task?.cancel()
        
        var request = profileRequest
        request?.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let request = request else { return }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let body):
                    let profile = Profile(
                        userName: body.userName,
                        name: "\(body.firstName) \(body.lastName ?? "")",
                        bio: body.bio ?? ""
                    )
                    self.profile = profile
                    completion(.success(profile))
                    self.task = nil
                case .failure(let error):
                    self.profile = nil
                    completion(.failure(error))
                }
            }
        }
        self.task = task
        task.resume()
    }
}

// MARK: - Methods
private extension ProfileService {
    var profileRequest: URLRequest? {
        URLRequest.makeHTTPRequest(
            path: "/me",
            httpMethod: "GET")
    }
}

struct ProfileResult: Codable {
    let userName: String
    let firstName: String
    let lastName: String?
    let bio: String?
    
    private enum CodingKeys: String, CodingKey {
        case userName
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
    }
}

struct Profile {
    let userName: String
    let name: String
    var loginName: String {
        get {
            "@\(userName)"
        }
    }
    let bio: String
}
