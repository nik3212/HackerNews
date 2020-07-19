//
//  StoriesInteractor.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation
import NetworkManager
import enum HNService.StoryType
import protocol HNService.HNServiceProtocol

class StoriesInteractor {
    // MARK: Public Properties
    weak var output: StoriesInteractorOutput?
    var networkService: HNServiceProtocol?
}

// MARK: StoriesInteractorInput
extension StoriesInteractor: StoriesInteractorInput {
    func fetchIds(for type: StoryType) {
        networkService?.fetchIds(for: type, completion: { [weak self] ids in
            self?.output?.fetchIdsSuccess(ids)
        }, fail: { [weak self] error in
            self?.output?.fetchIdsFail(error: error)
        })
    }
    
    func fetchPosts(with ids: [Int]) {
        networkService?.loadPosts(with: ids, completion: { [weak self] news in
            self?.output?.fetchItemsSuccess(news)
        }, fail: { [weak self] error in
            self?.output?.fetchItemsFailed(error: error)
        })
    }
    
    func cancleRequests() {
        networkService?.cancelAllTasks()
    }
}
