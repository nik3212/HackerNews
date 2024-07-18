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

        var paginator: PaginatorState<ShortCommentView.ViewModel, Int>

        @PresentationState var replies: RepliesFeature.State?
    }

    enum Action {
        case refresh
        case replyButtonTapped(commentID: Int)
        case child(PaginatorAction<ShortCommentView.ViewModel, Never, OffsetPaginationRequest>)
        case replies(PresentationAction<RepliesFeature.Action>)
    }

    // MARK: Dependencies

    @Dependency(\.commentsPager) var pager
    @Dependency(\.postDetailViewModelFactory) var viewModelFactory

    // MARK: Reducer

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .refresh:
                return .send(.child(.requestPage(.initial)), animation: .default)
            case .child:
                return .none
            case .replies:
                return .none
            case let .replyButtonTapped(commentID):
                state.replies = RepliesFeature.State(commentID: commentID, replies: [])
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
        .ifLet(\.$replies, action: \.replies) {
            RepliesFeature()
        }
    }
}

// MARK: - Constants

private extension OffsetPaginationRequest {
    static let initial = OffsetPaginationRequest(limit: 5, offset: .zero)
}
