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
        Store(initialState: NewsViewStore.State(selectedItem: .new, news: [])) {
            NewsViewStore(newsService: self.newsService)
        }
    }()

    // MARK: Initialization

    init(newsService: INewsService) {
        self.newsService = newsService
    }

    // MARK: Private

    func assemble() -> AnyView {
//            NavigationSplitView {
        NewsView(store: store).eraseToAnyView()
    }
}
