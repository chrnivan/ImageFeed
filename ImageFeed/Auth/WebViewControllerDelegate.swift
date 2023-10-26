//
//  WebViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Ivan on 16.10.2023.
//
import Foundation

protocol WebViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewController)
}
