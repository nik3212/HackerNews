//
//  HNService.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import NetworkManager

final class HNService: BaseService { }

// MARK: HNServiceProtocol
extension HNService: HNServiceProtocol {
    func loadTopStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        let resource = TopStoriesResource()
        load(resource: resource, completion: completion, fail: fail)
    }

    func loadNewStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        let resource = NewStoriesResource()
        load(resource: resource, completion: completion, fail: fail)
    }
    
    func loadBestStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        let resource = BestStoriesResource()
        load(resource: resource, completion: completion, fail: fail)
    }
    
    func loadItems(with ids: [Int], completion: @escaping ([ItemModel]) -> Void, fail: @escaping (Error) -> Void) {
        let resources = ids.map(ItemResource.init)
        load(resources: resources, completion: completion, fail: fail)
    }
}
