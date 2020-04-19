//
//  StoriesInteractorInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol StoriesInteractorInput {
    func loadStories()
    func loadNews(with ids: [Int])
}
