//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Paginator

public extension Reducer {
    func paginator<ItemState: Equatable & Identifiable>(
        limit: Int = 20,
        state: WritableKeyPath<State, PaginatorState<ItemState>>,
        action: AnyCasePath<Action, PaginatorAction<ItemState, Never>>,
        loadPage: @Sendable @escaping (LimitPageRequest, State) async throws -> Page<ItemState>
    ) -> some Reducer<State, Action> {
        PaginatorIntegrationReducer(
            limit: limit,
            parent: self,
            childState: state,
            childAction: action,
            loadPage: loadPage
        )
    }
}
