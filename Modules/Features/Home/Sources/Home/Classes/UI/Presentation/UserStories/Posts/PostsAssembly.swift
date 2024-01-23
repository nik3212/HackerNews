//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Paginator
import PaginatorTCA
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
        Store(
            initialState: PostsViewStore.State(
                selectedItem: .new,
                paginator: PaginatorState(items: [])
            )
        ) {
            PostsViewStore(
                viewModelFactory: self.viewModelFactory,
                pager: self.pager
            )
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

    private var pager: PostsPager {
        let paginators = Dictionary(uniqueKeysWithValues: PostType.allCases.map {
            let paginatorService = PostsPaginatorService(postsService: self.postsService, postType: $0)
            let paginator = PageLoader(paginatorService: paginatorService)
            return ($0, paginator)
        })

        return PostsPager(paginators: paginators)
    }
}
