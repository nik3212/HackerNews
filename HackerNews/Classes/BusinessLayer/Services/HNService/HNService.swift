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
    
    func loadNews(with ids: [Int], completion: @escaping ([NewsModel]) -> Void, fail: @escaping (Error) -> Void) {
        let resources = ids.map(NewsResource.init)
        load(resources: resources, completion: completion, fail: fail)
    }
}
