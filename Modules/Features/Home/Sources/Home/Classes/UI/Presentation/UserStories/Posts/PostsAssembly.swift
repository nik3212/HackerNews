//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import AppUtils
import Blade
import BladeTCA
import ComposableArchitecture
import SwiftUI

// MARK: - IPostsAssembly

protocol IPostsAssembly {
    func assemble() -> AnyView
}

// MARK: - PostsAssembly

final class PostsAssembly: BootstrappableAssembly, IPostsAssembly {
    // MARK: Properties

    private let postsService: IPostsService
    private let appNameProvider: IAppNameProvider
    private let postDetailsAssembly: IPostDetailAssembly

    private lazy var store: StoreOf<PostsViewStore> = Store(
        initialState: PostsViewStore.State(
            selectedItem: .new,
            paginator: PaginatorState(items: [], position: .zero)
        )
    ) {
        PostsViewStore()
    }

    // MARK: Initialization

    init(postsService: IPostsService, appNameProvider: IAppNameProvider, postDetailsAssembly: IPostDetailAssembly) {
        self.postsService = postsService
        self.appNameProvider = appNameProvider
        self.postDetailsAssembly = postDetailsAssembly
        super.init()
    }

    // MARK: Override

    override func bootstrap() {
        Locator.shared.register(.singleton) {
            let paginators = Dictionary(uniqueKeysWithValues: PostType.allCases.map {
                let paginatorService = PostsPaginatorService(postsService: self.postsService, postType: $0)
                let paginator = PageLoaderProvider(paginatorService: paginatorService)
                return ($0, paginator)
            })

            return PostsPager(paginators: paginators)
        }
    }

    // MARK: Public

    func assemble() -> AnyView {
        PostsView(
            store: store,
            navigationTitleAssembly: navigationTitleAssembly,
            postDetailsAssembly: postDetailsAssembly
        ).eraseToAnyView()
    }

    // MARK: Private

    private var viewModelFactory: IPostViewModelFactory {
        PostViewModelFactory()
    }

    private var navigationTitleAssembly: INavigationTitleAssembly {
        NavigationTitleAssembly(
            appNameProvider: appNameProvider,
            dateTimeFormatter: RelativeDateTimeFormatter()
        )
    }
}
