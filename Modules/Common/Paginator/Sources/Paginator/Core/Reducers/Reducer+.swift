//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture

public extension Reducer {
    func paginator<ItemState: Equatable & Identifiable>(
        state: WritableKeyPath<State, PaginatorState<ItemState>>,
        action: AnyCasePath<Action, PaginatorAction<ItemState, Never>>,
        loadPage: @Sendable @escaping (LimitPageRequest, State) async throws -> Page<ItemState>
    ) -> some Reducer<State, Action> {
        PaginatorIntegrationReducer(
            parent: self,
            childState: state,
            childAction: action,
            loadPage: loadPage
        )
    }
}
