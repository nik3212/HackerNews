//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

// MARK: - IPostsAssembly

protocol IPostsAssembly {
    func assemble() -> AnyView
}

// MARK: - PostsAssembly

final class PostsAssembly: IPostsAssembly {
    // MARK: Properties

    private let postsService: IPostsService
    private let appNameProvider: IAppNameProvider

    private lazy var store: StoreOf<PostsViewStore> = {
        Store(initialState: PostsViewStore.State(selectedItem: .new, articles: [])) {
            PostsViewStore(postsService: self.postsService, viewModelFactory: self.viewModelFactory)
        }
    }()

    // MARK: Initialization

    init(postsService: IPostsService, appNameProvider: IAppNameProvider) {
        self.postsService = postsService
        self.appNameProvider = appNameProvider
    }

    // MARK: Public

    func assemble() -> AnyView {
        PostsView(store: store, navigationTitleAssembly: navigationTitleAssembly).eraseToAnyView()
    }

    // MARK: Private

    private var viewModelFactory: IPostViewModelFactory {
        PostViewModelFactory()
    }

    private var navigationTitleAssembly: INavigationTitleAssembly {
        NavigationTitleAssembly(appNameProvider: appNameProvider)
    }
}
