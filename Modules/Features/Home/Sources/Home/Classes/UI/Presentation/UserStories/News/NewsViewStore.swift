//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation

struct NewsViewStore: Reducer {
    // MARK: Types

    struct State: Equatable {
        @BindingState var selectedItem: PostType
        var news: [News]
    }

    enum Action {
        case fetchNews
        case newsFetched(news: [News])
        case binding(PostType)
    }

    // MARK: Properties

    private let newsService: INewsService

    // MARK: Initialization

    init(newsService: INewsService) {
        self.newsService = newsService
    }

    // MARK: Reducer

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchNews:
            return .run { send in
                try await send(.newsFetched(news: newsService.loadNews(ids: [])))
            }
        case let .binding(postType):
            state.selectedItem = postType
            return .none
        case .newsFetched:
            return .none
        }
    }
}
