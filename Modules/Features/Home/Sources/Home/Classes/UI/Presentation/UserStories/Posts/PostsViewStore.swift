//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation
import Paginator

// MARK: - PostsViewStore

@Reducer
struct PostsViewStore {
    // MARK: Types

    struct State: Equatable {
        @BindingState var selectedItem: PostType
        var isLoading = false

        var paginator: PaginatorState<ArticleView.ViewModel>
    }

    enum Action {
        case refresh
        case fetchPosts(PostType)
        case postsResponse(result: Result<[Post], Error>, force: Bool)
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
                return .run { [type = state.selectedItem] send in
                    await send(self.fetch(type: type, force: true), animation: .default)
                }
            case let .fetchPosts(type):
                state.isLoading = true
                return .run { send in await send(self.fetch(type: type, force: false), animation: .default) }
                    .cancellable(id: CancelID.postRequest)
            case let .binding(postType):
                state.paginator.items = []
                state.selectedItem = postType
                return .send(.fetchPosts(postType))
            case let .postsResponse(.success(posts), force):
                state.isLoading = false
                if force {
                    state.paginator.items = .init(viewModelFactory.makeViewModel(from: posts))
                } else {
                    state.paginator.items += viewModelFactory.makeViewModel(from: posts)
                }
                return .none
            case .postsResponse(.failure, _):
                state.isLoading = false
                return .none
            case let .child(action):
                return .none
            }
        }
        .paginator(
            state: \PostsViewStore.State.paginator,
            action: /PostsViewStore.Action.child,
            loadPage: { request, state in
                let page = try await self.pager.load(request: request, postType: state.selectedItem)
                let items = self.viewModelFactory.makeViewModel(from: page.items)
                let viewModels = Page(items: items, offset: page.offset, hasMoreData: page.hasMoreData)
                return viewModels
            }
        )
    }

    // MARK: Private

    private func fetch(type: PostType, force: Bool) async -> Action {
        await .postsResponse(
            result: Result { try await self.pager.loadNext(postType: type) },
            force: force
        )
    }
}
