//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation

public enum PaginatorAction<State: Equatable & Identifiable, Action: Equatable>: Equatable {
    case itemAppeared(State.ID)
    case requestPage(LimitPageRequest)
    case response(TaskResult<Page<State>>)
}
