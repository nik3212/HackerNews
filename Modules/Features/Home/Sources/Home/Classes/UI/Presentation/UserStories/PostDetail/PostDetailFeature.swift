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
        var viewModel: ArticleView.ViewModel
        var paginator: PaginatorState<ShortCommentView.ViewModel, Int>
        var isSafariViewPresented: Bool = false
        var safariURL: URL?
        var hasComments: Bool = true

        @PresentationState var replies: RepliesFeature.State?
    }

    enum Action {
        case presentSafariView(URL?)
        case dismissSafariView
        case refresh
        case postLoaded(post: Post?)
        case replyButtonTapped(commentID: Int)
        case child(PaginatorAction<ShortCommentView.ViewModel, Never, OffsetPaginationRequest>)
        case replies(PresentationAction<RepliesFeature.Action>)
    }

    // MARK: Dependencies

    @Dependency(\.postsService) var postsService
    @Dependency(\.commentsPager) var pager
    @Dependency(\.postDetailViewModelFactory) var viewModelFactory
    @Dependency(\.postsViewModelFactory) var postsViewModelFactory

    // MARK: Reducer

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .refresh:
                return .run { [state] send in
                    let post = try await postsService.loadPosts(with: [state.viewModel.articleID])
                    return await send(.postLoaded(post: post.first))
                }
            case let .presentSafariView(url):
                state.safariURL = url
                state.isSafariViewPresented = true
                return .none
            case .dismissSafariView:
                state.isSafariViewPresented = false
                state.safariURL = nil
                return .none
            case let .postLoaded(post):
                if let post {
                    state.viewModel = postsViewModelFactory.makeViewModel(from: post)
                    state.hasComments = !post.kids.isEmpty
                }
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
                try await pager.load(request: request, postID: state.viewModel.articleID)
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
