//
//  HNService.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import NetworkManager

protocol HNServiceProtocol {
    func loadTopStories(completion: @escaping (Item) -> Void, fail: @escaping (Error) -> Void)
}

final class HNService: BaseService { }

extension HNService: HNServiceProtocol {
    func loadTopStories(completion: @escaping (Item) -> Void, fail: @escaping (Error) -> Void) {
        let resource = TopStoriesResource()
        load(resource: resource, completion: completion, fail: fail)
    }
}
