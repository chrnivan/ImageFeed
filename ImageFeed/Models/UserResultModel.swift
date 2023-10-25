//
//  UserResultModel.swift
//  ImageFeed
//
//  Created by Ivan on 25.10.2023.
//

import Foundation

struct UserResult: Codable {
    let profileImage: [String:String]
    
    enum CodingKeys: String, CodingKey {
        case profileImage = "profile_image"
    }
}
