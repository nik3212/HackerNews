//
//  MockDataTask.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

final class MockDataTask: URLSessionDataTask {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    // MARK: Private Properties
    private let data: Data?
    private let urlResponse: URLResponse?
    private let responseError: Error?
    
    // MARK: Public Properties
    var completionHandler: CompletionHandler?
    
    // MARK: Initialization
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.responseError = error
        super.init()
    }
    
    // MARK: Override
    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler?(self.data, self.urlResponse, self.responseError)
        }
    }
}
