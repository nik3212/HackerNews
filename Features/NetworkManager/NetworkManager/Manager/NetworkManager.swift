//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

final public class NetworkManager {
    
    // MARK: Public Properties
    
    /// A `NetworkSession` value that contains the current HTTP session.
    let session: NetworkSession
    
    // MARK: Initialization
    
    /// Create a new `NetworkManager` instance.
    ///
    /// - Parameter session: A `NetworkSession` value that contains the current HTTP session.
    public init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
}

// MARK: NetworkManagerProtocol
extension NetworkManager: NetworkManagerProtocol {
    public func fetch<R: APIResource>(_ resource: R, completion: @escaping (R.ModelType) -> Void, fail: @escaping (Error) -> Void) {
        let request = APIRequest(resource: resource)
        
        guard let urlRequest = try? request.buildRequest() else {
            return
        }
        
        let task = session.dataTask(with: urlRequest) { (data: Data?, _, error: Error?) in
            if let error = error {
                DispatchQueue.main.async {
                    fail(error)
                }
                return
            }
            
            guard let data = data, let model = try? JSONDecoder().decode(R.ModelType.self, from: data) else {
                DispatchQueue.main.async {
                    fail(NetworkError.decodingFailed)
                }
                return
            }

            DispatchQueue.main.async {
                completion(model)
            }
        }
        task.resume()
    }
    
    func cancelAllTasks() {
        
    }
}
