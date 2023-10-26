//
//  AuthViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Ivan on 16.10.2023.
//
import UIKit

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}
