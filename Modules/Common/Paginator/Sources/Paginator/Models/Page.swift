//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

public struct Page<T: Equatable>: Equatable {
    public let items: [T]
    public let offset: Int
    public let hasMoreData: Bool

    public init(items: [T], offset: Int, hasMoreData: Bool) {
        self.items = items
        self.offset = offset
        self.hasMoreData = hasMoreData
    }
}
