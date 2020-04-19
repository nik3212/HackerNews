//
//  StoriesInteractor.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation

class StoriesInteractor {
    // MARK: Public Properties
    weak var output: StoriesInteractorOutput?
    var networkService: HNServiceProtocol?
}

// MARK: StoriesInteractorInput
extension StoriesInteractor: StoriesInteractorInput {
    func loadStories() {
        networkService?.loadTopStories(completion: { [weak self] ids in
            self?.output?.loadTopStoriesSuccess(ids: ids)
        }, fail: { [weak self] error in
            self?.output?.loadTopStoriesFailed(error: error)
        })
    }
    
    func loadNews(with ids: [Int]) {
        networkService?.loadNews(with: ids, completion: { [weak self] news in
            self?.output?.loadItemsSuccess(news)
        }, fail: { [weak self] error in
            self?.output?.loadItemsFailed(error: error)
        })
    }
}
