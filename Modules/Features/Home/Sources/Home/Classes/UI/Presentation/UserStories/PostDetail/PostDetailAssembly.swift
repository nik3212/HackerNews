//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import AppUtils
import ComposableArchitecture
import SwiftUI

// MARK: - IPostDetailAssembly

protocol IPostDetailAssembly {
    func assemble(store: StoreOf<PostDetailFeature>) -> AnyView
}

// MARK: - PostDetailAssembly

final class PostDetailAssembly: BootstrappableAssembly, IPostDetailAssembly {
    // MARK: Properties

    private let commentsService: ICommentsService
    private let postsService: IPostsService
    private let repliesAssembly: IRepliesAssembly

    // MARK: Initialization

    init(commentsService: ICommentsService, postsService: IPostsService, repliesAssembly: IRepliesAssembly) {
        self.commentsService = commentsService
        self.postsService = postsService
        self.repliesAssembly = repliesAssembly
    }

    // MARK: IPostDetailAssembly

    func assemble(store: StoreOf<PostDetailFeature>) -> AnyView {
        let view = PostDetailView(store: store, repliesAssembly: repliesAssembly)
        return view.eraseToAnyView()
    }

    // MARK: BootstrappableAssembly

    override func bootstrap() {
        Locator.shared.register(type: ICommentsPager.self) {
            let paginator = CommentsPaginatorService(
                commentsService: self.commentsService,
                postsService: self.postsService
            )
            return CommentsPager(paginator: paginator)
        }
    }
}
