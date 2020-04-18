//
//  APIRequest.swift
//  NetworkManager
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

public class APIRequest<Resource: APIResource> {
    
    // MARK: Public Properties

    let session: NetworkSession
    let resource: Resource
    
    /// Create a new `APIRequest` instance.
    ///
    /// - Parameters:
    ///   - resource: An `APIResource` resource object that provides the URL, cache policy, request type, body data or body stream, and so on.
    ///   - session: A `URLSession` value that contains the current HTTP session.
    public init(resource: Resource, session: NetworkSession = URLSession.shared) {
        self.resource = resource
        self.session = session
    }
}

// MARK: NetworkRequest
extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let model = try? JSONDecoder().decode(Resource.ModelType.self, from: data)
        return model
    }
    
    public func load(withCompletion completion: @escaping (Resource.ModelType) -> Void, fail: @escaping (Error) -> Void) {
        load(resource, completion: completion, fail: fail)
    }
}
