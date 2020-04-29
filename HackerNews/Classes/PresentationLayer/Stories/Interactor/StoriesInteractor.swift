//
//  StoriesInteractor.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation
import NetworkManager

class StoriesInteractor {
    // MARK: Public Properties
    weak var output: StoriesInteractorOutput?
    var networkService: HNServiceProtocol?
}

// MARK: StoriesInteractorInput
extension StoriesInteractor: StoriesInteractorInput {
    func fetchTopStories() {
        networkService?.loadTopStories(completion: { [weak self] ids in
            self?.output?.fetchTopStoriesSuccess(ids: ids)
        }, fail: { [weak self] error in
            self?.output?.fetchTopStoriesFailed(error: error)
        })
    }
    
    func fetchBestStories() {
        networkService?.loadBestStories(completion: { [weak self] ids in
            self?.output?.fetchBestStoriesSuccess(ids: ids)
            }, fail: { [weak self] error in
            self?.output?.fetchBestStoriesFailed(error: error)
        })
    }
    
    func fetchNewStories() {
        output?.fetchNewStoriesFailed(error: NetworkError.encodingFailed)
//        networkService?.loadNewStories(completion: { [weak self] ids in
//            self?.output?.fetchNewStoriesSuccess(ids: ids)
//            }, fail: { [weak self] error in
//            self?.output?.fetchNewStoriesFailed(error: error)
//        })
    }
    
    func fetchPosts(with ids: [Int]) {
        networkService?.loadPosts(with: ids, completion: { [weak self] news in
            self?.output?.fetchItemsSuccess(news)
        }, fail: { [weak self] error in
            self?.output?.fetchItemsFailed(error: error)
        })
    }
}
