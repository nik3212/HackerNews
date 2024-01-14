//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation

struct PostsViewStore: Reducer {
    // MARK: Types

    struct State: Equatable {
        @BindingState var selectedItem: PostType
        var articles: [ArticleView.ViewModel]
    }

    enum Action {
        case refresh
        case fetchPosts(PostType)
        case postsResponse(Result<[Post], Error>)
        case binding(PostType)
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

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .refresh:
            return .run { [type = state.selectedItem] send in
                await send(.fetchPosts(type))
            }
        case let .fetchPosts(type):
            return .run { send in
                await send(
                    .postsResponse(Result { try await self.pager.loadNext(postType: type) }),
                    animation: .default
                )
            }
            .cancellable(id: CancelID.postRequest)
        case let .binding(postType):
            state.articles = []
            state.selectedItem = postType
            return .send(.fetchPosts(postType))
        case let .postsResponse(.success(posts)):
            state.articles = viewModelFactory.makeViewModel(from: posts)
            return .none
        case .postsResponse(.failure):
            return .none
        }
    }
}
