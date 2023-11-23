//
//  WebViewViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Ivan on 16.11.2023.
//

import Foundation
import ImageFeed

final class WebViewViewControllerSpy: WebViewControllerProtocol {
    func estimatedProgressObservtion() {
        
    }
    
    var presenter: ImageFeed.WebViewPresenterProtocol?
    
    var loadRequestCalled: Bool = false
    
    func load(request: URLRequest) {
        loadRequestCalled = true
    }
    
    func setProgressValue(_ newValue: Float) {
        
    }
    
    func setProgressHidden(_ isHidden: Bool) {
        
    }
    
    
}
