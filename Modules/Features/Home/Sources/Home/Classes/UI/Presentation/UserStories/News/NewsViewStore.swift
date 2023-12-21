//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation

struct NewsViewStore: Reducer {
    // MARK: Types

    struct State {
        var news: [News]
    }

    enum Action {
        case fetchNews
        case newsFetched(news: [News])
    }

    // MARK: Properties

    private let newsService: INewsService

    // MARK: Initialization

    init(newsService: INewsService) {
        self.newsService = newsService
    }

    @Dependency(\.newsService) var newsService1

    // MARK: Reducer

    func reduce(into _: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .fetchNews:
            return .run { send in
//                try await newsService1.loadNews(ids: [])
                try await send(.newsFetched(news: newsService.loadNews(ids: [])))
            }
        case .newsFetched:
            return .none
        }
    }
}
