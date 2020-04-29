//
//  NetworkSession.swift
//  NetworkManager
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

public protocol NetworkSession: class {
    /// Creates a task that retrieves the contents of the specified URL, then calls a handler upon completion.
    /// 
    /// - Parameters:
    ///   - request: The URL to be retrieved.
    ///   - completionHandler: The completion handler to call when the load request is complete. This handler is executed on the delegate queue.
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Swift.Error?) -> Swift.Void) -> URLSessionDataTask
    
    /// Asynchronously calls a completion callback with all tasks in a session
    func getAllTasks(completionHandler: @escaping ([URLSessionTask]) -> Void)
    
    /// <#Description#>
    func cancelAllTasks()
}

// MARK: NetworkSession
extension URLSession: NetworkSession {
    public func cancelAllTasks() {
        self.getAllTasks { $0.forEach { $0.cancel() } }
    }
}
