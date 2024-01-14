//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation
import NetworkLayerInterfaces

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
}
