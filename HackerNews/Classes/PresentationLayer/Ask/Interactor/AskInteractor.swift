//
//  AskInteractor.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation
import protocol HNService.HNServiceProtocol

final class AskInteractor {
    // MARK: Public Properties
    weak var output: AskInteractorOutput!
    var networkService: HNServiceProtocol?
}

// MARK: AskInteractorInput
extension AskInteractor: AskInteractorInput {
    func fetchAskIds() {
        networkService?.loadAskStories(completion: { [weak self] ids in
            self?.output.fetchAskSuccess(ids: ids)
            }, fail: { [weak self] error in
            self?.output.fetchAskFailed(error: error)
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
