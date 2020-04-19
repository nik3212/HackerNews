//
//  StoriesInteractorOutput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol StoriesInteractorOutput: class {
    func loadTopStoriesSuccess(ids: [Int])
    func loadTopStoriesFailed(error: Error)
    
    func loadItemsSuccess(_ items: [NewsModel])
    func loadItemsFailed(error: Error)
}
