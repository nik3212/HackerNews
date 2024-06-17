//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Blade
import Foundation

// MARK: - ICommentsPager

protocol ICommentsPager {
    func load(request: OffsetPaginationRequest, behaviour: LoadBehaviour, postID: Int) async throws -> Page<Comment>
}

extension ICommentsPager {
    func load(request: OffsetPaginationRequest, postID: Int) async throws -> Page<Comment> {
        try await load(request: request, behaviour: .useCache, postID: postID)
    }
}
