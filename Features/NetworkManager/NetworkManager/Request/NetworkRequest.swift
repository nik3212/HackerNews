//
//  NetworkRequest.swift
//  NetworkManager
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

/// Network errors
public enum NetworkError: String, Error {
    case encodingFailed = "Parameter encoding failed."
    case decodingFailed = "Parameter decoding failed."
    case missingURL = "URL is nil."
}

/// Network request
protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    
    /// A `URLSession` value that contains the current HTTP session.
    var session: NetworkSession { get }
    
    /// Decode object to model.
    ///
    /// - Parameter data: A `Data` value that represents the object.
    ///
    /// - Returns: The value that contains decoded object.
    func decode(_ data: Data) -> ModelType?
    
    /// Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion.
    ///
    /// - Parameter completion: A block object to be executed when the load ends.
    /// - Parameter fail: A block object to be execute when the load fails.
    func load(withCompletion completion: @escaping (ModelType) -> Void, fail: @escaping (Error) -> Void)
}

extension NetworkRequest {
    /// Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion.
    ///
    /// - Parameters:
    ///   - apiResource: An `APIResource` resource object that provides the URL, cache policy, request type, body data or body stream, and so on.
    ///   - completion: A block object to be executed when the load ends.
    ///   - fail: A block object to be execute when the load fails.
    func load<T: APIResource>(_ apiResource: T, completion: @escaping (ModelType) -> Void, fail: @escaping (Error) -> Void) {
        guard let request = try? buildRequest(from: apiResource) else {
            fail(NetworkError.missingURL)
            return
        }
        
        let task = session.dataTask(with: request) { [weak self] (data: Data?, _, error: Error?) in
            if let error = error {
                fail(error)
                return
            }
            
            guard let data = data, let model = self?.decode(data) else {
                fail(NetworkError.decodingFailed)
                return
            }

            completion(model)
        }
        task.resume()
    }
    
    /// Build `URLRequest` from resource.
    ///
    /// - Parameter resource: An `APIResource` resource object that provides the URL, cache policy, request type, body data or body stream, and so on.
    ///
    /// - Returns: A URL load request that is independent of protocol or URL scheme.
    ///
    /// - Throws: `NetworkError.encodingFailed`.
    private func buildRequest<T: APIResource>(from resource: T) throws -> URLRequest? {
        var request = URLRequest(url: resource.baseURL.appendingPathComponent(resource.path),
                                 cachePolicy: resource.cachePolicy,
                                 timeoutInterval: resource.timeout)
        
        request.httpMethod = resource.httpMethod.rawValue
        
        do {
            switch resource.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, urlRequest: &request)
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let headers):
                self.addAdditionalHeaders(additionalHeaders: headers, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, urlRequest: &request)
            }
            
            return request
        } catch {
            throw error
        }
    }
    
    /// Configure the `urlRequest` with the specified parameters.
    ///
    /// - Parameters:
    ///   - bodyParameters: The data sent as the message body of a request, such as for an HTTP POST request.
    ///   - urlParameters: The items for the URL in the order in which they appear in the original query string.
    ///   - urlRequest: A URL load request that is independent of protocol or URL scheme.
    ///
    /// - Throws: `NetworkError.encodingFailed`.
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, urlRequest: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    /// Add additional headers to the request.
    ///
    /// - Parameters:
    ///   - additionalHeaders: Sets a value for the header field.
    ///   - request: A URL load request that is independent of protocol or URL scheme.
    fileprivate func addAdditionalHeaders(additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
