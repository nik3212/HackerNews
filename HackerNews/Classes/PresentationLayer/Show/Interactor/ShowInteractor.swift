//
//  ShowInteractor.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation
import protocol HNService.HNServiceProtocol

final class ShowInteractor {
    // MARK: Public Properties
    weak var output: ShowInteractorOutput!
    var networkService: HNServiceProtocol?
}

// MARK: ShowInteractorInput
extension ShowInteractor: ShowInteractorInput {
    func fetchShowIds() {
        networkService?.loadShowStories(completion: { [weak self] ids in
            self?.output.fetchShowStoriesSuccess(ids: ids)
            }, fail: { [weak self] error in
            self?.output.fetchShowStoriesFailed(error: error)
        })
    }
    
    func fetchPosts(with ids: [Int]) {
        networkService?.loadPosts(with: ids, completion: { [weak self] models in
            self?.output.fetchPostsSuccess(models)
        }, fail: { [weak self] error in
            self?.output.fetchPostsFailed(error: error)
        })
    }
}
