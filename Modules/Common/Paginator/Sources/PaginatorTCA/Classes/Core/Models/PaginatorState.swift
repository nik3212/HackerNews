//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation

public struct PaginatorState<State: Equatable & Identifiable>: Equatable {
    // MARK: Properties

    public var items: IdentifiedArrayOf<State>

    // TODO: Cursor-based pagination

    var isLoading: Bool
    var offset: Int
    var hasMoreData: Bool

    // MARK: Initialization

    public init(items: IdentifiedArrayOf<State>) {
        self.items = items
        isLoading = false
        hasMoreData = true
        offset = .zero
    }
}
