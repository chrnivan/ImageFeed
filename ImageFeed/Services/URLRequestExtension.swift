//
//  URLRequestExtension.swift
//  ImageFeed
//
//  Created by Ivan on 16.10.2023.
//

import UIKit

extension URLRequest {
    static func makeHTTPRequest(
        path: String,
        httpMethod: String,
        baseURL: URL? = KeyAndUrl.defaultBaseUrl
    ) -> URLRequest? {
        var request = URLRequest(url: URL(string: path, relativeTo: baseURL) ?? KeyAndUrl.defaultBaseUrl)
        request.httpMethod = httpMethod
        return request
    }
}

