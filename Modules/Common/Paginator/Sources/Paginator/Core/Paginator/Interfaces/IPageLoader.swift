//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

/// A protocol defining the interface for loading paginated data.
public protocol IPageLoader<Element> {
    /// The type of elements the paginator is handling, which must conform to `Decodable` & `Equatable`.
    associatedtype Element: Decodable & Equatable

    /// Loads a page of elements based on the provided pagination request asynchronously.
    ///
    /// - Parameters:
    ///   - request: A `LimitPageRequest` specifying the limit and offset for the requested page.
    ///
    /// - Returns: An asynchronous task representing the loading process, resolving to a `Page` of elements.
    func loadPage(request: LimitPageRequest) async throws -> Page<Element>
}
