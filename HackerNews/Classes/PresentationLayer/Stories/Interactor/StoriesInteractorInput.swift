//
//  StoriesInteractorInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import enum HNService.StoryType
import protocol HNService.HNServiceProtocol

protocol StoriesInteractorInput {
    var output: StoriesInteractorOutput? { get set }
    var networkService: HNServiceProtocol? { get set }
    
    func fetchIds(for type: StoryType)
    
    func fetchPosts(with ids: [Int])
    func cancleRequests()
}
