//
//  APIResource.swift
//  NetworkManager
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public protocol APIResource {
    associatedtype ModelType: Decodable
    
    /// The URL for the request.
    var baseURL: URL { get }
    
    /// The path to endpoint.
    var path: String { get }
    
    /// The value for the header field.
    var httpHeaders: HTTPHeaders? { get }
    
    /// The parameters  for the URL in the order in which they appear in the original query string.
    var bodyParameters: Parameters? { get }
    
    /// The HTTP request method.
    var httpMethod: HTTPMethod { get }
    
    /// The task type.
    var task: HTTPTask { get }
    
    /// The cache policy for the request
    var cachePolicy: URLRequest.CachePolicy { get }
    
    /// The timeout interval for the request. The default is 60.0.
    var timeout: TimeInterval { get }
}

public extension APIResource {
    var headers: Parameters? {
        return nil
    }
    
    var bodyParameters: Parameters? {
        return nil
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }
    
    var timeout: TimeInterval {
        return 60
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var httpHeaders: HTTPHeaders? {
        return nil
    }
}
