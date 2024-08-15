//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Blade
import BladeTCA
import ComposableArchitecture
import Foundation

// MARK: - PostsViewStore

@Reducer
struct PostsViewStore {
    // MARK: Types

    struct State: Equatable {
        @BindingState var selectedItem: PostType
        var selectedPostID: ArticleView.ViewModel.ID?
        @PresentationState var postDetail: PostDetailFeature.State?

        var paginator: PaginatorState<ArticleView.ViewModel, Int>
    }

    enum Action {
        case refresh
        case binding(PostType?)

        case selectItem(ArticleView.ViewModel)
        case postDetail(PresentationAction<PostDetailFeature.Action>)
        case child(PaginatorAction<ArticleView.ViewModel, Never, OffsetPaginationRequest>)
    }

    // MARK: Properties

    @Dependency(\.postsViewModelFactory) var viewModelFactory
    @Dependency(\.postsPager) var pager

    // MARK: Reducer

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .refresh:
                return .send(.child(.requestPage(.initial)), animation: .default)
            case let .binding(postType):
                guard let postType, postType != state.selectedItem else {
                    return .none
                }
                state.paginator.items = []
                state.selectedItem = postType
                return .send(.refresh)
            case let .selectItem(viewModel):
                state.selectedPostID = viewModel.id
                state.postDetail = .init(
                    viewModel: viewModel,
                    paginator: .init(items: [], position: .zero)
                )
                return .none
            case .child:
                return .none
            case .postDetail(.dismiss):
                state.selectedPostID = nil
                state.postDetail = nil
                return .none
            case .postDetail(.presented):
                return .none
            }
        }
        .paginator(
            state: \PostsViewStore.State.paginator,
            action: /PostsViewStore.Action.child,
            loadPage: { request, state in
                try await pager.load(request: request, postType: state.selectedItem)
                    .map { viewModelFactory.makeViewModel(from: $0) }
            }
        )
        .ifLet(\.$postDetail, action: \.postDetail) {
            PostDetailFeature()
        }
    }
}

// MARK: - Constants

private extension OffsetPaginationRequest {
    static let initial = OffsetPaginationRequest(limit: 20, offset: .zero)
}
