//
//  ProfileImageModel.swift
//  ImageFeed
//
//  Created by Ivan on 25.10.2023.
//

import Foundation

struct ProfileImage: Codable {
    let smallImage: [String:String]
    
    init(callData: UserResult) {
        self.smallImage = callData.profileImage
    }
}
