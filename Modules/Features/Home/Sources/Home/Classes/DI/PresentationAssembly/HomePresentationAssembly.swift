//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation
import SettingsInterfaces

// MARK: - IHomePresentationAssembly

protocol IHomePresentationAssembly {
    var newsAssembly: IPostsAssembly { get }
}

// MARK: - HomePresentationAssembly

final class HomePresentationAssembly: IHomePresentationAssembly {
    // MARK: Properties

    private let settingsAssembly: ISettingsPublicAssembly
    private let servicesAssembly: IHomeServicesAssembly

    // MARK: Initialization

    init(servicesAssembly: IHomeServicesAssembly, settingsAssembly: ISettingsPublicAssembly) {
        self.servicesAssembly = servicesAssembly
        self.settingsAssembly = settingsAssembly
    }

    // MARK: IHomePresentationAssembly

    var newsAssembly: IPostsAssembly {
        PostsAssembly(
            postsService: servicesAssembly.postsService,
            appNameProvider: servicesAssembly.appNameProvider,
            postDetailsAssembly: postDetailsAssembly,
            settingsAssembly: settingsAssembly
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
