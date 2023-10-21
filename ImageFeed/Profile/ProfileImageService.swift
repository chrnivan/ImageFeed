//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Ivan on 15.10.2023.
//

import Foundation

final class ProfileImageService {
    
    //MARK: - Private Properties
    static let shared = ProfileImageService()
    private (set) var avatarURL: String?
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    static let DidChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    // MARK: - Public Methods
    func fetchProfileImageURL(
        token: String,
        username: String,
        _ completion: @escaping (Result<String, Error>) -> Void
    ){
        assert(Thread.isMainThread)
        if avatarURL != nil { return }
        task?.cancel()
        
        var request = profileImageRequest(userName: username)
        request?.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let request = request else {
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .success(let body):
                    let avatarURL = body.profileImage.small
                    
                    guard let avatarURL = avatarURL else { return }
                    self.avatarURL = avatarURL
                    
                    completion(.success(avatarURL))
                    NotificationCenter.default
                        .post(
                            name: ProfileImageService.DidChangeNotification,
                            object: self,
                            userInfo: ["URL": avatarURL])
                    
                    self.task = nil
                case .failure(let error):
                    completion(.failure(error))
                    self.avatarURL = nil
                }
            }
        }
        
        self.task = task
        task.resume()
    }
}

struct UserResult: Codable {
    let profileImage: ProfileImage
}

struct ProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?
}

// MARK: - Public Methods
private extension ProfileImageService {
    func profileImageRequest(userName: String) -> URLRequest? {
        URLRequest.makeHTTPRequest(
            path: "/users/\(userName)",
            httpMethod: "GET"
        )
    }
}

