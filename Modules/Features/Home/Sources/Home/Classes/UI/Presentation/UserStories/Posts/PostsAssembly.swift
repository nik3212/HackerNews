//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
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

    private lazy var store: StoreOf<PostsViewStore> = {
        Store(initialState: PostsViewStore.State(selectedItem: .new, articles: [])) {
            PostsViewStore(postsService: self.postsService, viewModelFactory: self.viewModelFactory)
        }
    }()

    // MARK: Initialization

    init(postsService: IPostsService) {
        self.postsService = postsService
    }

    // MARK: Public

    func assemble() -> AnyView {
        PostsView(store: store).eraseToAnyView()
    }

    // MARK: Private

    private var viewModelFactory: IPostViewModelFactory {
        PostViewModelFactory()
    }
}
