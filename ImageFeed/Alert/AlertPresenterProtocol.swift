//
//  AlertPresenterProtocol.swift
//  ImageFeed
//
//  Created by Ivan on 16.10.2023.
//

import Foundation

protocol AlertPresenterProtocol: AnyObject {
    func showError(for model: AlertModel)
}
