//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

// import ComposableArchitecture
import Foundation
import Paginator

actor PostsPaginatorService: IPaginatorService {
    // MARK: Properties

    private let postsService: IPostsService
    private let postType: PostType

    private var ids: [PostType: [Int]] = [:]

    // MARK: Initialization

    init(postsService: IPostsService, postType: PostType) {
        self.postsService = postsService
        self.postType = postType
    }

    // MARK: IPaginatorService

    func loadPage(_ limit: Int, offset: Int) async throws -> Page<Post> {
        let ids = try await prefetchIDs(for: postType)
        let posts = try await postsService.loadPosts(
            with: Array(ids[safe: offset ..< limit + offset])
        )

        let offset = limit + offset

        return Page(
            items: posts,
            offset: offset,
            hasMoreData: offset < ids.count
        )
    }

    // MARK: Private

    private func prefetchIDs(for postType: PostType) async throws -> [Int] {
        if let ids = ids[postType], !ids.isEmpty { return ids }

        let ids = try await postsService.loadIDs(for: postType)
        self.ids[postType] = ids
        return ids
    }
}

// MARK: Private

private extension Array {
    subscript(safe range: Range<Int>) -> [Element] {
        let minIndex = Swift.max(range.lowerBound, 0)
        let maxIndex = Swift.min(range.upperBound, count - 1)

        guard minIndex <= maxIndex else {
            return []
        }

        return Array(self[minIndex ..< maxIndex])
    }
}
