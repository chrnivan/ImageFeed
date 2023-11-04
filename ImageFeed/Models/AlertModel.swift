//
//  AlertModel.swift
//  ImageFeed
//
//  Created by Ivan on 16.10.2023.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: () -> Void
    var nextButtonText: String?
    var nextCompletion: () -> Void = {}
}
