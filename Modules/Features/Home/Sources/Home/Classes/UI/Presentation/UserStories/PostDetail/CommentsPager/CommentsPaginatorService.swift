//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Blade
import Foundation

// MARK: - CommentsPaginatorService

actor CommentsPaginatorService {
    // MARK: Properties

    private let commentsService: ICommentsService
    private let postsService: IPostsService

    private var ids: [Int] = []

    // MARK: Initialization

    init(commentsService: ICommentsService, postsService: IPostsService) {
        self.commentsService = commentsService
        self.postsService = postsService
    }

    // MARK: IOffsetPageLoader

    func loadPage(request: OffsetPaginationRequest, behaviour: LoadBehaviour, postID: Int) async throws -> Page<Comment> {
        ids = try await loadCommentsIDs(postID: postID, behaviour: behaviour)
        let comments = try await loadComments(ids: Array(ids[safe: request.offset ... request.limit + request.offset - 1]))

        return Page(items: comments, hasMoreData: comments.count < ids.count)
    }

    // MARK: Private

    private func loadCommentsIDs(postID: Int, behaviour: LoadBehaviour) async throws -> [Int] {
        var ids: [Int] = []

        switch behaviour {
        case .reload:
            let post = try await postsService.loadPosts(with: [postID]).first
            ids = post?.kids ?? []
        case .useCache:
            if !ids.isEmpty { return ids }
            return try await loadCommentsIDs(postID: postID, behaviour: .reload)
        }

        return ids
    }

    private func loadComments(ids: [Int]) async throws -> [Comment] {
        try await ids.asyncMap { id in
            try await self.commentsService.loadComment(id: id)
        }
    }
}

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
}
