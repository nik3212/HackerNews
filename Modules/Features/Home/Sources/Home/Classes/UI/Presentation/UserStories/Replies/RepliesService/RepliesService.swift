//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

// MARK: - RepliesService

final class RepliesService {
    // MARK: Properties

    private let commentsService: ICommentsService

    // MARK: Initialization

    init(commentsService: ICommentsService) {
        self.commentsService = commentsService
    }
}

// MARK: IRepliesService

extension RepliesService: IRepliesService {
    func loadComments(for id: Int) async throws -> ReplyComment {
        let comment = try await commentsService.loadComment(id: id)

        if comment.kids.isEmpty {
            return ReplyComment(comment: comment)
        }

        let subComments = try await withThrowingTaskGroup(of: ReplyComment.self, returning: [ReplyComment].self) { taskGroup in
            for id in comment.kids {
                taskGroup.addTask { try await self.loadComments(for: id) }
            }

            let comments = try await taskGroup.reduce(into: [ReplyComment]()) { $0.append($1) }
                .sorted(by: { $0.comment.time < $1.comment.time })
            return comments
        }

        return ReplyComment(comment: comment, replies: subComments)
    }
}
