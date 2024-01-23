//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation
import NetworkLayerInterfaces
import Paginator

actor PostsPager {
    // MARK: Properties

    private let paginators: [PostType: any IPaginator<Post>]

    // MARK: Initialization

    init(paginators: [PostType: any IPaginator<Post>]) {
        self.paginators = paginators
    }

    // MARK: Public

    func refresh(postType: PostType) async throws -> [Post] {
        try await paginators[postType]?.refresh().items ?? []
    }

    func loadNext(postType: PostType) async throws -> [Post] {
        try await paginators[postType]?.loadNextPage().items ?? []
    }

    func reset(postType: PostType) async {
        await paginators[postType]?.reset()
    }

    func load(request: LimitPageRequest, postType: PostType) async throws -> Page<Post> {
        // FIXME: Remove force unwrapping
        // swiftlint:disable:next force_unwrapping
        try await paginators[postType]!.loadPage(request: request)
    }
}
