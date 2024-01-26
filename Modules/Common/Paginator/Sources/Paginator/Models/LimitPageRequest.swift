//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

/// A struct representing a request for paginated data with specified limits and offsets.
public struct LimitPageRequest: Equatable {
    // MARK: Properties

    /// The maximum number of items to be included in a page.
    public let limit: Int

    /// The offset indicating the position of the first item in the requested page
    /// relative to the entire dataset.
    public let offset: Int

    // MARK: Initialization

    /// Creates a ``LimitPageRequest`` instance.
    ///
    /// - Parameters:
    ///   - limit: The maximum number of items to be included in a page.
    ///   - offset: The offset indicating the position of the first item in the requested page
    ///             relative to the entire dataset.
    public init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
}
