//
//  URLParameterEncoder.swift
//  NetworkManager
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public protocol ParameterEncoder {
    /// Encode items for the URL in the order in which they appear in the original query string.
    ///
    /// - Parameters:
    ///   - urlRequest: A URL load request that is independent of protocol or URL scheme.
    ///   - parameters: The object from which to generate items.
    ///
    /// - Throws: `NetworkError.missingURL` if url request contains is not valid URL.
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

/// URL encoder.
public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.url = urlComponents.url
        }
    }
}
