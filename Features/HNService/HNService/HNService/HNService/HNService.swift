//
//  HNService.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import NetworkManager

final public class HNService: BaseService { }

// MARK: HNServiceProtocol
extension HNService: HNServiceProtocol {
    public func loadTopStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        let resource = TopStoriesResource()
        load(resource: resource, completion: completion, fail: fail)
    }

    public func loadNewStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        let resource = NewStoriesResource()
        load(resource: resource, completion: completion, fail: fail)
    }
    
    public func loadBestStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        let resource = BestStoriesResource()
        load(resource: resource, completion: completion, fail: fail)
    }
    
    public func loadAskStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        let resource = AskStoriesResource()
        load(resource: resource, completion: completion, fail: fail)
    }
    
    public func loadShowStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void) {
        let resource = ShowStoriesResource()
        load(resource: resource, completion: completion, fail: fail)
    }
    
    public func loadPosts(with ids: [Int], completion: @escaping ([PostModel]) -> Void, fail: @escaping (Error) -> Void) {
        let resources = ids.map(NewsResource.init)
        load(resources: resources, completion: completion, fail: fail)
    }
    
    public func loadPost(with id: Int, completion: @escaping (PostModel) -> Void, fail: @escaping (Error) -> Void) {
        let resource = NewsResource(id: id)
        load(resource: resource, completion: completion, fail: fail)
    }
    
    public func loadComment(with id: Int, completion: @escaping (CommentModel) -> Void, fail: @escaping (Error) -> Void) {
        let resource = CommentResource(id: id)
        load(resource: resource, completion: completion, fail: fail)
    }
    
    public func loadComments(with id: Int, completion: @escaping (CommentModel) -> Void, fail: @escaping (Error) -> Void) {
        loadComment(with: id, completion: { comment in
            var commentObject = comment
            
            guard !commentObject.kids.isEmpty else {
                completion(commentObject)
                return
            }
            
            var subcomments: [CommentModel] = []
            
            let group = DispatchGroup()
            
            for id in comment.kids {
                group.enter()
                self.loadComments(with: id, completion: { model in
                    subcomments.append(model)
                    group.leave()
                }, fail: { error in
                    fail(error)
                    return
                })
            }
            
            group.notify(queue: .main) {
                commentObject.comments = subcomments
                completion(commentObject)
            }
        }, fail: { error in
            fail(error)
        })
    }
}
