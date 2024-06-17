//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Blade
import Foundation
import NetworkLayerInterfaces

actor PostsPager {
    // MARK: Properties

    private let paginators: [PostType: any IOffsetPageLoader<Post>]

    // MARK: Initialization

    init(paginators: [PostType: any IOffsetPageLoader<Post>]) {
        self.paginators = paginators
    }

    // MARK: Public

    func load(request: OffsetPaginationRequest, postType: PostType) async throws -> Page<Post> {
        // FIXME: Remove force unwrapping
        // swiftlint:disable:next force_unwrapping
        try await paginators[postType]!.loadPage(request: request)
    }
}
