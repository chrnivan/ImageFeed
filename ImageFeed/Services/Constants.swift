//
//  URLSessionExtension.swift
//  Constants
//
//  Created by Ivan on 16.10.2023.
//

import Foundation

let AccessKey = "RBgK4eZU4r0xWJYur0_0XpQ4m1RUZxFeLr9g6LlLyp8"
let SecretKey = "IfIn60JRdySIoLJU-HVyoCURTf-9rYkwcB1D9X_sYrI"
let AccessScope = "public+read_user+write_likes"
let DefaultBaseURL = URL(string: "https://api.unsplash.com")!
let RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
let UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
let defaultBaseApiURL = URL(string: "https://api.unsplash.com/")!

struct ProfileResult: Codable {
    let userName: String
    let firstName: String
    let lastName: String
    let bio: String?
    
    private enum CodingKeys: String, CodingKey {
        case userName = "username"
        case firstName = "first_name"
        case lastName = "last_name"
        case bio = "bio"
    }
}

struct Profile {
    let userName: String
    let name: String
    let loginName: String
    let bio: String?
    
    init(callData: ProfileResult) {
        self.userName = callData.userName
        self.name = (callData.firstName ) + " " + (callData.lastName )
        self.loginName = "@" + (callData.userName )
        self.bio = callData.bio
    }
}

struct UserResult: Codable {
    let profileImage: [String:String]
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let smallImage: [String:String]
    
    init(callData: UserResult) {
        self.smallImage = callData.profileImage
    }
}
