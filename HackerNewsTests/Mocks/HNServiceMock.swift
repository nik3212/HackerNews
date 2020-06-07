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
    
    var loadTopStoriesCompletion: (([Int]) -> Void)?
    var loadTopStoriesFail: ((Error) -> Void)?
    
    var loadBestStoriesCompletion: (([Int]) -> Void)?
    var loadBestStoriesFail: ((Error) -> Void)?
    
    var loadNewStoriesCompletion: (([Int]) -> Void)?
    var loadNewStoriesFail: ((Error) -> Void)?
    
    var loadPostsCompletion: (([PostModel]) -> Void)?
    var loadPostsFail: ((Error) -> Void)?
    var postsIds: [Int]?
    
    func loadTopStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        loadTopStoriesCalled = true
        loadTopStoriesCompletion = completion
        loadTopStoriesFail = fail
    }
    
    func loadNewStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        loadNewStoriesCalled = true
        loadNewStoriesCompletion = completion
        loadNewStoriesFail = fail
    }
    
    func loadBestStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        loadBestStoriesCalled = true
        loadBestStoriesCompletion = completion
        loadBestStoriesFail = fail
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
