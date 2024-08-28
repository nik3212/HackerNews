//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import AppUtils
import ComposableArchitecture
import SwiftUI

// MARK: - IRepliesAssembly

protocol IRepliesAssembly {
    func assemble(store: StoreOf<RepliesFeature>) -> AnyView
}

// MARK: - RepliesAssembly

final class RepliesAssembly: BootstrappableAssembly, IRepliesAssembly {
    // MARK: Properties

    private let commentsService: ICommentsService
    private let postsService: IPostsService

    // MARK: Initialization

    init(commentsService: ICommentsService, postsService: IPostsService) {
        self.commentsService = commentsService
        self.postsService = postsService
    }

    // MARK: IRepliesAssembly

    func assemble(store: StoreOf<RepliesFeature>) -> AnyView {
        let view = RepliesView(store: store)
        return view.eraseToAnyView()
    }

    // MARK: IBootstrappable

    override func bootstrap() {
        Locator.shared.register(type: IRepliesService.self) {
            RepliesService(commentsService: self.commentsService)
        }
    }
}
