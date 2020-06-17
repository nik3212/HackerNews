//
//  BaseService.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import NetworkManager

public protocol NetworkService {
    func load<R: APIResource>(resource: R, completion: @escaping (R.ModelType) -> Void, fail: @escaping (Error) -> Void)
    func load<R: APIResource>(resources: [R], completion: @escaping ([R.ModelType]) -> Void, fail: @escaping (Error) -> Void)
    func cancelAllTasks()
}

public class BaseService: NetworkService {
    let session: NetworkSession
    let networkManager: NetworkManager
    
    public init(networkManager: NetworkManager = NetworkManager(), session: NetworkSession = URLSession.shared) {
        self.session = session
        self.networkManager = networkManager
    }
    
    public func load<R: APIResource>(resource: R, completion: @escaping (R.ModelType) -> Void, fail: @escaping (Error) -> Void) {
        networkManager.fetch(resource, completion: completion, fail: fail)
    }
    
    public func load<R: APIResource>(resources: [R], completion: @escaping ([R.ModelType]) -> Void, fail: @escaping (Error) -> Void) {
        let group = DispatchGroup()
        var responces: [R.ModelType] = []
        
        for resource in resources {
            group.enter()

            load(resource: resource, completion: { model in
                responces.append(model)
                group.leave()
            }, fail: { error in
                fail(error)
            })
        }
        
        group.notify(queue: .main) {
            completion(responces)
        }
    }
    
    public func cancelAllTasks() {
        networkManager.cancelAllTasks()
    }
}
