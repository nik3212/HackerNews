//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Paginator

extension Page {
    func map<U: Equatable>(_ closure: @escaping (T) throws -> U) rethrows -> Page<U> {
        let items = try self.items.map { try closure($0) }
        let page = Page<U>(
            items: items,
            offset: offset,
            hasMoreData: hasMoreData
        )
        return page
    }
}
