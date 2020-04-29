//
//  HNServiceProtocol.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

protocol HNServiceProtocol {
    func loadTopStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void)
    func loadNewStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void)
    func loadBestStories(completion: @escaping ([Int]) -> Void, fail: @escaping (Error) -> Void)
    func loadPosts(with ids: [Int], completion: @escaping ([PostModel]) -> Void, fail: @escaping (Error) -> Void)
    func loadComments(with id: Int, completion: @escaping (CommentModel) -> Void, fail: @escaping (Error) -> Void)
}