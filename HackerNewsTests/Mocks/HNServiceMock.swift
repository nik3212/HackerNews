//
//  HNServiceMock.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 07.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import HNService

@testable import HackerNews

final class HNServiceMock: HNServiceProtocol {
    var fetchIdsCalled: Bool = false
    var loadPostsCalled: Bool = false
    var loadCommentsCalled: Bool = false
    var cancelAllTasksCalled: Bool = false

    var type: StoryType?
    var fetchIdsCompletion: (([Int]) -> Void)?
    var fetchIdsFail: ((Error) -> Void)?
    
    var loadPostsCompletion: (([PostModel]) -> Void)?
    var loadPostsFail: ((Error) -> Void)?
    var postsIds: [Int]?
    
    var loadCommentsId: Int?
    var loadCommentsCompletion: ((CommentModel) -> Void)?
    var loadCommentsFail: ((Error) -> Void)?
    
    func fetchIds(for type: StoryType, completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        fetchIdsCalled = true
        fetchIdsCompletion = completion
        fetchIdsFail = fail
    }
    
    func loadPosts(with ids: [Int], completion: @escaping ([PostModel]) -> Void, fail: @escaping (Error) -> Void) {
        postsIds = ids
        loadPostsCalled = true
        loadPostsCompletion = completion
        loadPostsFail = fail
    }
    
    func loadComments(with id: Int, completion: @escaping (CommentModel) -> Void, fail: @escaping (Error) -> Void) {
        loadCommentsCalled = true
        loadCommentsId = id
        loadCommentsCompletion = completion
        loadCommentsFail = fail
    }
    
    func cancelAllTasks() {
        cancelAllTasksCalled = true
    }
}
