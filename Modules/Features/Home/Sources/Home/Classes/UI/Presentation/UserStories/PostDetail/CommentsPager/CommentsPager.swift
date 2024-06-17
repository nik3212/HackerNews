//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Blade
import Foundation

actor CommentsPager: ICommentsPager {
    // MARK: Properties

    private let paginator: CommentsPaginatorService

    // MARK: Initialization

    init(paginator: CommentsPaginatorService) {
        self.paginator = paginator
    }

    // MARK: Public

    func load(request: OffsetPaginationRequest, behaviour: LoadBehaviour, postID: Int) async throws -> Page<Comment> {
        try await paginator.loadPage(request: request, behaviour: behaviour, postID: postID)
    }
}
