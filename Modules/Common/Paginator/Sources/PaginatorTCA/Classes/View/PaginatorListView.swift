//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public struct PaginatorListView<State: Equatable & Identifiable, Action: Equatable, Body: View>: View {
    // MARK: Properties

    public let store: Store<PaginatorState<State>, PaginatorAction<State, Action>>
    public let content: (State) -> Body

    public init(
        store: Store<PaginatorState<State>, PaginatorAction<State, Action>>,
        content: @escaping (State) -> Body
    ) {
        self.store = store
        self.content = content
    }

    // MARK: View

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { (viewStore: ViewStoreOf<PaginatorReducer<State, Action>>) in
            List(viewStore.items) { item in
                content(item)
                    .onAppear {
                        viewStore.send(.itemAppeared(item.id))
                    }
            }

            if viewStore.isLoading {
                ProgressView().progressViewStyle(.circular)
            }
        }
    }
}
