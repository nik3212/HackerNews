//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

/// A generic struct representing a paginated collection of items.
public struct Page<T: Equatable>: Equatable {
    // MARK: Properties

    /// An array of items of generic type T contained in the current page.
    public let items: [T]

    /// The offset indicating the position of the first item in the current page
    /// relative to the entire collection.
    public let offset: Int

    /// A boolean flag indicating whether there are more data available beyond
    /// the current page.
    public let hasMoreData: Bool

    // MARK: Initializaiton

    /// Creates a `Page` instance.
    ///
    /// - Parameters:
    ///   - items: An array of items of generic type T contained in the current page.
    ///   - offset: The offset indicating the position of the first item in the current page relative to the entire collection.
    ///   - hasMoreData: A boolean flag indicating whether there are more data available beyond the current page.
    public init(items: [T], offset: Int, hasMoreData: Bool) {
        self.items = items
        self.offset = offset
        self.hasMoreData = hasMoreData
    }
}
