//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

/// Protocol defining the interface for a service responsible for loading paginated data.
public protocol IPaginatorService<Element> {
    /// The type of elements the service is handling, which must conform to `Decodable`.
    associatedtype Element: Decodable & Equatable

    /// Asynchronously loads a specific page of data.
    ///
    /// - Parameter page: The page index to load.
    ///
    /// - Returns: A `PageInfo` representing the loaded data.
    ///
    /// - Throws: An error if there's an issue during the loading process.
    func loadPage(_ limit: Int, offset: Int) async throws -> Page<Element>
}
