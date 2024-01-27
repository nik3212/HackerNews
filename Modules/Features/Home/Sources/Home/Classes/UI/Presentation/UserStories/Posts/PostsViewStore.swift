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
        var selectedPostID: ArticleView.ViewModel.ID?
        @PresentationState var postDetail: PostDetailFeature.State?

        var paginator: PaginatorState<ArticleView.ViewModel>
    }

    enum Action {
        case refresh
        case binding(PostType)

        case selectItem(UUID)
        case postDetail(PresentationAction<PostDetailFeature.Action>)
        case child(PaginatorAction<ArticleView.ViewModel, Never>)
    }

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
            case let .binding(postType):
                state.paginator.items = []
                state.selectedItem = postType
                return .send(.refresh)
            case let .selectItem(id):
                state.selectedPostID = id
                state.postDetail = .init(postID: "\(id)")
                return .none
            case .child:
                return .none
            case .postDetail(.dismiss):
                state.selectedPostID = nil
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
        .ifLet(\.$postDetail, action: \.postDetail) {
            PostDetailFeature()
        }
    }
}

// MARK: - Constants

private extension LimitPageRequest {
    static let initial = LimitPageRequest(limit: 20, offset: .zero)
}