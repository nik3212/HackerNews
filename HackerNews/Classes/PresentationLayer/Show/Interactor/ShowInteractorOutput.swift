//
//  ShowInteractorOutput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import struct HNService.PostModel

protocol ShowInteractorOutput: class {
    func fetchShowStoriesSuccess(ids: [Int])
    func fetchShowStoriesFailed(error: Error)
    
    func fetchPostsSuccess(_ posts: [PostModel])
    func fetchPostsFailed(error: Error)
}
