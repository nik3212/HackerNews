//
//  AskInteractorOutput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol AskInteractorOutput: class {
    func fetchAskSuccess(ids: [Int])
    func fetchAskFailed(error: Error)
    
    func fetchPostsSuccess(_ posts: [PostModel])
    func fetchPostsFailed(error: Error)
}
