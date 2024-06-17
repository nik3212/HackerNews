//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Blade
import BladeTCA
import ComposableArchitecture
import Foundation

// MARK: - PostDetailFeature

@Reducer
struct PostDetailFeature {
    // MARK: Types

    struct State: Equatable {
        let postID: Int

        var paginator: PaginatorState<CommentView.ViewModel, Int>
    }

    enum Action {
        case refresh
        case child(PaginatorAction<CommentView.ViewModel, Never, OffsetPaginationRequest>)
    }

    // MARK: Dependencies

    @Dependency(\.commentsPager) var pager
    @Dependency(\.postDetailViewModelFactory) var viewModelFactory

    // MARK: Reducer

    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .refresh:
                return .send(.child(.requestPage(.initial)), animation: .default)
            case .child:
                return .none
            }
        }
        .paginator(
            state: \PostDetailFeature.State.paginator,
            action: /PostDetailFeature.Action.child,
            loadPage: { request, state in
                try await pager.load(request: request, postID: state.postID)
                    .map { viewModelFactory.makeViewModel(from: $0) }
            }
        )
    }
}

// MARK: - Constants

private extension OffsetPaginationRequest {
    static let initial = OffsetPaginationRequest(limit: 5, offset: .zero)
}
