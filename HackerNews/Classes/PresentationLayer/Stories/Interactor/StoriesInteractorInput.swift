//
//  StoriesInteractorInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol StoriesInteractorInput {
    func fetchTopStories()
    func fetchBestStories()
    func fetchNewStories()
    func fetchPosts(with ids: [Int])
}
