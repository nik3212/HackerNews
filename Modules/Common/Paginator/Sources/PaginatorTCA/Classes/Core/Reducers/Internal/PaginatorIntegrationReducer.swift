//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Paginator

struct PaginatorIntegrationReducer<
    Parent: Reducer,
    State: Equatable & Identifiable,
    Action: Equatable
>: Reducer {
    // MARK: Properties

    let limit: Int
    let parent: Parent
    let childState: WritableKeyPath<Parent.State, PaginatorState<State>>
    let childAction: AnyCasePath<Parent.Action, PaginatorAction<State, Action>>
    let loadPage: @Sendable(LimitPageRequest, Parent.State) async throws -> Page<State>

    // MARK: Reducer

    var body: some Reducer<Parent.State, Parent.Action> {
        Scope(state: childState, action: childAction) {
            PaginatorReducer(limit: limit)
        }

        Reduce { state, action in
            guard let paginatorAction = childAction.extract(from: action),
                  case let .requestPage(pageRequest) = paginatorAction
            else {
                return self.parent.reduce(into: &state, action: action)
            }

            return .run { [state] send in
                await send(childAction.embed(.response(TaskResult { try await self.loadPage(pageRequest, state) })))
            }
        }
    }
}
