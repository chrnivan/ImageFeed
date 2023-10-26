//
//  URLSessionExtension.swift
//  Constants
//
//  Created by Ivan on 16.10.2023.
//

import Foundation

struct KeyAndUrl {
    static let accessKey = "RBgK4eZU4r0xWJYur0_0XpQ4m1RUZxFeLr9g6LlLyp8"
    static let secretKey = "IfIn60JRdySIoLJU-HVyoCURTf-9rYkwcB1D9X_sYrI"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseUrl = URL(string: "https://api.unsplash.com")!
    static let redirectUrl = "urn:ietf:wg:oauth:2.0:oob"
    static let unsplashAuthorizeUrlString = "https://unsplash.com/oauth/authorize"
    static let defaultBaseApiUrl = URL(string: "https://api.unsplash.com/")!
}
