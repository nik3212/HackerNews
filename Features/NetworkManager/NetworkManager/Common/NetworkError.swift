//
//  NetworkError.swift
//  NetworkManager
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

/// Network errors
public enum NetworkError: String, Error {
    /// For encoding errors, such as failing to encode parameters.
    case encodingFailed = "Parameter encoding failed."
    
    /// For decoding errors, such as failing to decode a response from the server.
    case decodingFailed = "Parameter decoding failed."
    
    /// For not valid URL.
    case missingURL = "URL is nil."
    
    /// For client side errors, such as failing to build a request to the server.
    case client = "Building request is failed."
}
