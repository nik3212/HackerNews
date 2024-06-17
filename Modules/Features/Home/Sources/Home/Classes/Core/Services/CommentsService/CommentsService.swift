//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation
import NetworkLayer
import NetworkLayerInterfaces

// MARK: - CommentsService

final class CommentsService {
    // MARK: Private

    private let requestProcessor: IRequestProcessor

    // MARK: Initialization

    init(requestProcessor: IRequestProcessor) {
        self.requestProcessor = requestProcessor
    }

    // MARK: Private

    private func _loadComment(id: Int) async throws -> Comment {
        let request = CommentRequest(id: id)
        return try await requestProcessor.send(request, strategy: nil, delegate: nil, configure: nil).data
    }
}

// MARK: ICommentsService

extension CommentsService: ICommentsService {
    func loadComment(id: Int) async throws -> Comment {
        var comment = try await _loadComment(id: id)

        if comment.kids.isEmpty {
            return comment
        }

        let subComments = try await withThrowingTaskGroup(of: Comment.self, returning: [Comment].self) { taskGroup in
            for id in comment.kids {
                taskGroup.addTask { try await self._loadComment(id: id) }
            }

            let comments = try await taskGroup.reduce(into: [Comment]()) { $0.append($1) }
//                            .sorted(by: { $0.time < $1.time })
            return comments
        }

        comment.comments = subComments

        return comment
    }
}
