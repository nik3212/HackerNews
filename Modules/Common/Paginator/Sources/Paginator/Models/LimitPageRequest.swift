//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

public struct LimitPageRequest: Equatable {
    // MARK: Properties

    public let limit: Int
    public let offset: Int

    // MARK: Initialization

    public init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
}
