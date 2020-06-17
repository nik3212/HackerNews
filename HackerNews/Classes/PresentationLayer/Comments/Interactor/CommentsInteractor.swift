//
//  CommentsInteractor.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation
import protocol HNService.HNServiceProtocol

class CommentsInteractor {
    // MARK: Public Proeprties
    weak var output: CommentsInteractorOutput!
    var networkService: HNServiceProtocol?
}

// MARK: CommentsInteractorInput
extension CommentsInteractor: CommentsInteractorInput {
    func fetchComments(for id: Int) {
        networkService?.loadComments(with: id, completion: { [weak self] comment in
            self?.output.fetchCommentsSuccess(comment)
        }, fail: { [weak self] error in
            self?.output.fetchCommentsFail(error: error)
        })
    }
}
