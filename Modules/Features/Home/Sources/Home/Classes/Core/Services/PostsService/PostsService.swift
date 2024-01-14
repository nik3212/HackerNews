//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation
import NetworkLayerInterfaces

// MARK: - PostsService

final class PostsService {
    // MARK: Private

    private let requestProcessor: IRequestProcessor

    // MARK: Initialization

    init(requestProcessor: IRequestProcessor) {
        self.requestProcessor = requestProcessor
    }

    // MARK: Private

    private func loadPost(withID id: Int) async throws -> Post {
        let request = PostRequest(id: id)
        return try await requestProcessor.send(request, strategy: nil, delegate: nil, configure: nil).data
    }
}

// MARK: IPostsService

extension PostsService: IPostsService {
    func loadIDs(for type: PostType) async throws -> [Int] {
        let request = PostIdentifiersRequest(postType: type)
        return try await requestProcessor.send(request, strategy: nil, delegate: nil, configure: nil).data
    }

    func loadPosts(with ids: [Int]) async throws -> [Post] {
        try await withThrowingTaskGroup(of: Post.self, returning: [Post].self, body: { taskGroup in
            for id in ids {
                taskGroup.addTask { try await self.loadPost(withID: id) }
            }

            return try await taskGroup.reduce(into: [Post]()) { $0.append($1) }
        })
    }

    func loadPosts(with type: PostType) async throws -> [Post] {
        let ids = try await loadIDs(for: type)
        return try await loadPosts(with: ids)
    }
}
