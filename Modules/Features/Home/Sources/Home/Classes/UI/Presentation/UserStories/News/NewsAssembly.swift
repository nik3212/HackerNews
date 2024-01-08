//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

// MARK: - INewsAssembly

protocol INewsAssembly {
    func assemble() -> AnyView
}

// MARK: - NewsAssembly

final class NewsAssembly: INewsAssembly {
    // MARK: Properties

    private let newsService: INewsService

    private lazy var store: StoreOf<NewsViewStore> = {
        Store(initialState: NewsViewStore.State(selectedItem: .new, articles: [])) {
            NewsViewStore(newsService: self.newsService, viewModelFactory: self.viewModelFactory)
        }
    }()

    // MARK: Initialization

    init(newsService: INewsService) {
        self.newsService = newsService
    }

    // MARK: Public

    func assemble() -> AnyView {
        NewsView(store: store).eraseToAnyView()
    }

    // MARK: Private

    private var viewModelFactory: IPostViewModelFactory {
        PostViewModelFactory()
    }
}
