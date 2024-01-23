//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation
import Paginator

/// Protocol defining the interface for a paginator that manages asynchronous loading of paginated data.
public protocol IPaginator<Element> {
    /// The type of elements the paginator is handling, which must conform to `Decodable` & `Equatable`.
    associatedtype Element: Decodable & Equatable

    /// Asynchronously refreshes the paginator, resetting to the first page and fetching new data.
    ///
    /// - Returns: A `PageInfo` representing the refreshed data.
    ///
    /// - Throws: An error if there's an issue during the refresh process.
    func refresh() async throws -> Page<Element>

    /// Asynchronously loads the next page of data.
    ///
    /// - Returns: A `PageInfo` representing the newly loaded data.
    ///
    /// - Throws: An error if there's an issue during the loading process.
    func loadNextPage() async throws -> Page<Element>

    // TODO: Возможно поделить на две сущности
    func loadPage(request: LimitPageRequest) async throws -> Page<Element>

    /// Asynchronously resets the paginator, clearing all previously loaded data and resetting the page index.
    func reset() async
}
