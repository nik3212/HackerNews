//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation

protocol IPostsService {
    func loadPosts(with type: PostType) async throws -> [Post]
}
