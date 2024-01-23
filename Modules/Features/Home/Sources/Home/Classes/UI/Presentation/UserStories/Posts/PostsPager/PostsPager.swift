//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation
import NetworkLayerInterfaces
import Paginator

actor PostsPager {
    // MARK: Properties

    private let paginators: [PostType: any IPageLoader<Post>]

    // MARK: Initialization

    init(paginators: [PostType: any IPageLoader<Post>]) {
        self.paginators = paginators
    }

    // MARK: Public

    func load(request: LimitPageRequest, postType: PostType) async throws -> Page<Post> {
        // FIXME: Remove force unwrapping
        // swiftlint:disable:next force_unwrapping
        try await paginators[postType]!.loadPage(request: request)
    }
}
