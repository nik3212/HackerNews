//
//  Configurable.swift
//  HackerNews
//
//  Created by Никита Васильев on 01/11/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation
import NetworkManager

class StoriesLoader {
    typealias Handler = (NSError?) -> Void
    
    private static func loadIds(to dataSource: StoriesListDataSource,
                                type: ItemType,
                                completion: @escaping Handler) {
        NetworkManager.shared.getIds(type: type) { (response) in
            switch response {
            case .success(let ids):
                dataSource.ids = ids
                completion(nil)
            case .error(let error):
                completion(error as NSError)
            }
        }
    }
    
    private static func retrive(to dataSource: StoriesListDataSource,
                                completion: @escaping Handler) {
        let count = dataSource.stories.count
        let ids: [Int]!
        let idsCount = dataSource.ids.count
        
        if count + 20 > idsCount {
            ids = Array(dataSource.ids[count..<idsCount])
        } else {
            ids = Array(dataSource.ids[count..<count + 20])
        }
        
        NetworkManager.shared.retrieve(ids: ids) { (response) in
            switch response {
            case .success(let stories):
                dataSource.stories.append(contentsOf: stories)
                completion(nil)
            case .error(let error):
                completion(error as NSError)
            }
        }
    }
    
    static func retrieve(to dataSource: StoriesListDataSource,
                         type: ItemType,
                         _ completion: @escaping Handler) {
        StoriesLoader.loadIds(to: dataSource, type: type) { (error) in
            if let error = error {
                completion(error)
            } else {
                self.retrive(to: dataSource, completion: completion)
            }
        }
    }
}
