//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation

// MARK: - PostsViewStore

struct PostsViewStore: Reducer {
    // MARK: Types

    struct State: Equatable {
        @BindingState var selectedItem: PostType
        var articles: [ArticleView.ViewModel]
        var isLoading = false
    }

    enum Action {
        case refresh
        case fetchPosts(PostType)
        case postsResponse(result: Result<[Post], Error>, force: Bool)
        case binding(PostType)
        case loadNext
        case appearItem(index: Int)
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

    // swiftlint:disable:next function_body_length
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .refresh:
            return .run { [type = state.selectedItem] send in
                await pager.reset(postType: type)
                await send(
                    .postsResponse(
                        result: Result { try await self.pager.refresh(postType: type) },
                        force: true
                    ),
                    animation: .default
                )
            }
        case .loadNext:
            return .run { [type = state.selectedItem] send in
                await send(.fetchPosts(type))
            }
        case let .fetchPosts(type):
            state.isLoading = true
            return .run { send in
                await send(
                    .postsResponse(
                        result: Result { try await self.pager.loadNext(postType: type) },
                        force: false
                    ),
                    animation: .default
                )
            }
            .cancellable(id: CancelID.postRequest)
        case let .binding(postType):
            state.articles = []
            state.selectedItem = postType
            return .send(.fetchPosts(postType))
        case let .postsResponse(.success(posts), force):
            state.isLoading = false
            if force {
                state.articles = viewModelFactory.makeViewModel(from: posts)
            } else {
                state.articles += viewModelFactory.makeViewModel(from: posts)
            }
            return .none
        case .postsResponse(.failure, _):
            state.isLoading = false
            return .none
        case let .appearItem(index):
            return prefetchDataIfNeeded(for: state, index: index)
        }
    }

    // MARK: Private

    private func prefetchDataIfNeeded(for state: State, index: Int) -> Effect<Action> {
        if index > state.articles.count - Int.pageSize, !state.isLoading {
            return .run { [type = state.selectedItem] send in
                await send(.fetchPosts(type))
            }
        }
        return .none
    }
}

// MARK: - Constants

private extension Int {
    static let pageSize = 15
}
