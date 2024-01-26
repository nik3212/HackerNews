//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Paginator
import SwiftUI

// MARK: - PaginatorView

public struct PaginatorView<
    State: Equatable & Identifiable,
    Action: Equatable,
    Body: View,
    RowContent: View
>: View {
    // MARK: Properties

    public let store: Store<PaginatorState<State>, PaginatorAction<State, Action>>
    public let content: ([State], @escaping (State) -> AnyView) -> Body
    public let rowContent: (State) -> RowContent

    // MARK: Initialization

    public init(
        store: Store<PaginatorState<State>, PaginatorAction<State, Action>>,
        @ViewBuilder content: @escaping ([State], @escaping (State) -> AnyView) -> Body,
        @ViewBuilder rowContent: @escaping (State) -> RowContent
    ) {
        self.store = store
        self.content = content
        self.rowContent = rowContent
    }

    // MARK: View

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { (viewStore: ViewStoreOf<PaginatorReducer<State, Action>>) in
            content(viewStore.items.elements) { item in
                rowContent(item)
                    .onAppear { viewStore.send(.itemAppeared(item.id)) }
                    .any
            }
            .modifier(LoadingViewModifier(isLoading: viewStore.isLoading && !viewStore.items.isEmpty))
        }
    }
}

// MARK: Extension

private extension View {
    var any: AnyView {
        AnyView(self)
    }
}
