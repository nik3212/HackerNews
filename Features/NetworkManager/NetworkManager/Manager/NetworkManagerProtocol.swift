//
//  NetworkManagerProtocol.swift
//  NetworkManager
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    /// A `NetworkSession` value that contains the current HTTP session.
    var session: NetworkSession { get }
    
    /// Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion.
    ///
    /// - Parameters:
    ///   - resource: An `APIResource` resource object that provides the URL, cache policy, request type, body data or body stream, and so on.
    ///   - completion: A block object to be executed when the load ends.
    ///   - fail: A block object to be execute when the load fails.
    func fetch<R: APIResource>(_ resource: R, completion: @escaping (R.ModelType) -> Void, fail: @escaping (Error) -> Void)
}
