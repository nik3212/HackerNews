//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation
import Paginator
import PaginatorTCA

// MARK: - PostsViewStore

@Reducer
struct PostsViewStore {
    // MARK: Types

    struct State: Equatable {
        @BindingState var selectedItem: PostType
        var paginator: PaginatorState<ArticleView.ViewModel>
    }

    enum Action {
        case refresh
        case binding(PostType)

        case child(PaginatorAction<ArticleView.ViewModel, Never>)
    }

    private enum CancelID { case postRequest }

    // MARK: Properties

    private let viewModelFactory: IPostViewModelFactory
    private let pager: PostsPager

    // MARK: Initialization

    init(viewModelFactory: IPostViewModelFactory, pager: PostsPager) {
        self.viewModelFactory = viewModelFactory
        self.pager = pager
    }

    // MARK: Reducer

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .refresh:
                return .send(.child(.requestPage(.initial)), animation: .default)
                    .cancellable(id: CancelID.postRequest)
            case let .binding(postType):
                state.paginator.items = []
                state.selectedItem = postType
                return .send(.refresh)
            case .child:
                return .none
            }
        }
        .paginator(
            state: \PostsViewStore.State.paginator,
            action: /PostsViewStore.Action.child,
            loadPage: { request, state in
                try await self.pager.load(request: request, postType: state.selectedItem)
                    .map { self.viewModelFactory.makeViewModel(from: $0) }
            }
        )
    }
}

// MARK: - Constants

private extension LimitPageRequest {
    static let initial = LimitPageRequest(limit: 20, offset: .zero)
}
