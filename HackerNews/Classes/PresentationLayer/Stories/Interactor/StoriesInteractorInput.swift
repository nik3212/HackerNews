//
//  StoriesInteractorInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import protocol HNService.HNServiceProtocol

protocol StoriesInteractorInput {
    var output: StoriesInteractorOutput? { get set }
    var networkService: HNServiceProtocol? { get set }
    
    func fetchTopStories()
    func fetchBestStories()
    func fetchNewStories()
    func fetchPosts(with ids: [Int])
    func cancleRequests()
}
