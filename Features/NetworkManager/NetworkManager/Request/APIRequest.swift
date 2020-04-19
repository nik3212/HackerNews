//
//  APIRequest.swift
//  NetworkManager
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

public struct APIRequest<Resource: APIResource> {
    
    // MARK: Public Properties

    /// An `APIResource` resource object that provides the URL, cache policy, request type, body data or body stream, and so on.
    let resource: Resource
    
    /// Create a new `APIRequest` instance.
    ///
    /// - Parameters:
    ///   - resource: An `APIResource` resource object that provides the URL, cache policy, request type, body data or body stream, and so on.
    ///   - session: A `URLSession` value that contains the current HTTP session.
    public init(resource: Resource) {
        self.resource = resource
    }
}

// MARK: NetworkRequest
extension APIRequest: NetworkRequest { }
