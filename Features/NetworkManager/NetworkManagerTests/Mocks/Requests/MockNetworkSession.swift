//
//  MockNetworkSession.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
@testable import NetworkManager

final class MockNetworkSession {
    // MARK: Public Properties
    var request: URLRequest?
    
    // MARK: Private Properties
    private var dataTask: MockDataTask
    
    // MARK: Initialization
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        dataTask = MockDataTask(data: data, urlResponse: urlResponse, error: error)
    }
}

// MARK: NetworkSession
extension MockNetworkSession: NetworkSession {
    func getAllTasks(completionHandler: @escaping ([URLSessionTask]) -> Void) {
        
    }
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        dataTask.completionHandler = completionHandler
        return dataTask
    }
}
