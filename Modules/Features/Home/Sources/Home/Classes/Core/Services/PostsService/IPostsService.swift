//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation

protocol IPostsService {
    func loadIDs(for type: PostType) async throws -> [Int]
    func loadPosts(with ids: [Int]) async throws -> [Post]
    func loadPosts(with type: PostType) async throws -> [Post]
}
