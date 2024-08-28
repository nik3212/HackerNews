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
        try await _loadComment(id: id)
    }
}
