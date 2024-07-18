//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation

// MARK: - IHomePresentationAssembly

protocol IHomePresentationAssembly {
    var newsAssembly: IPostsAssembly { get }
}

// MARK: - HomePresentationAssembly

final class HomePresentationAssembly: IHomePresentationAssembly {
    // MARK: Properties

    private let servicesAssembly: IHomeServicesAssembly

    // MARK: Initialization

    init(servicesAssembly: IHomeServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }

    // MARK: IHomePresentationAssembly

    var newsAssembly: IPostsAssembly {
        PostsAssembly(
            postsService: servicesAssembly.postsService,
            appNameProvider: servicesAssembly.appNameProvider,
            postDetailsAssembly: postDetailsAssembly
        )
    }

    // MARK: Private

    private var postDetailsAssembly: IPostDetailAssembly {
        PostDetailAssembly(
            commentsService: servicesAssembly.commentsService,
            postsService: servicesAssembly.postsService,
            repliesAssembly: repliesAssembly
        )
    }

    private var repliesAssembly: IRepliesAssembly {
        RepliesAssembly(
            commentsService: servicesAssembly.commentsService,
            postsService: servicesAssembly.postsService
        )
    }
}
