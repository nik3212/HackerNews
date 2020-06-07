//
//  HNServiceMock.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 07.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

@testable import HackerNews

final class HNServiceMock: HNServiceProtocol {
    var loadTopStoriesCalled: Bool = false
    var loadNewStoriesCalled: Bool = false
    var loadBestStoriesCalled: Bool = false
    var loadAskStoriesCalled: Bool = false
    var loadShowStoriesCalled: Bool = false
    var loadPostsCalled: Bool = false
    var loadCommentsCalled: Bool = false
    var cancelAllTasksCalled: Bool = false
    
    var loadAskStoriesCompletion: (([Int]) -> Void)?
    var loadAskStoriesFail: ((Error) -> Void)?
    
    var loadShowStoriesCompletion: (([Int]) -> Void)?
    var loadShowStoriesFail: ((Error) -> Void)?
    
    var loadPostsCompletion: (([PostModel]) -> Void)?
    var loadPostsFail: ((Error) -> Void)?
    var postsIds: [Int]?
    
    func loadTopStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        loadTopStoriesCalled = true
    }
    
    func loadNewStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        loadNewStoriesCalled = true
    }
    
    func loadBestStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        loadBestStoriesCalled = true
    }
    
    func loadAskStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        loadAskStoriesCalled = true
        loadAskStoriesCompletion = completion
        loadAskStoriesFail = fail
    }
    
    func loadShowStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        loadShowStoriesCalled = true
        loadShowStoriesCompletion = completion
        loadShowStoriesFail = fail
    }
    
    func loadPosts(with ids: [Int], completion: @escaping ([PostModel]) -> Void, fail: @escaping (Error) -> Void) {
        postsIds = ids
        loadPostsCalled = true
        loadPostsCompletion = completion
        loadPostsFail = fail
    }
    
    func loadComments(with id: Int, completion: @escaping (CommentModel) -> Void, fail: @escaping (Error) -> Void) {
        loadCommentsCalled = true
    }
    
    func cancelAllTasks() {
        cancelAllTasksCalled = true
    }
}
