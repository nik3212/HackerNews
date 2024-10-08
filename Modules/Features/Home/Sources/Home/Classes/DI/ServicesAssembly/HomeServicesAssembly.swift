//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import AppUtils
import Foundation
import NetworkLayerInterfaces

// MARK: - IHomeServicesAssembly

protocol IHomeServicesAssembly {
    var postsService: IPostsService { get }
    var commentsService: ICommentsService { get }
    var appNameProvider: IAppNameProvider { get }
}

// MARK: - HomeServicesAssembly

final class HomeServicesAssembly: AppAssembly, IHomeServicesAssembly {
    // MARK: Properties

    private let requestProcessor: IRequestProcessor

    // MARK: Initialization

    init(requestProcessor: IRequestProcessor) {
        self.requestProcessor = requestProcessor
    }

    // MARK: IHomeServicesAssembly

    var postsService: IPostsService {
        resolve(IPostsService.self) {
            PostsService(requestProcessor: self.requestProcessor)
        }
    }

    var appNameProvider: IAppNameProvider {
        resolve(IAppNameProvider.self) {
            AppNameProvider(bundle: .main)
        }
    }

    var commentsService: ICommentsService {
        resolve(ICommentsService.self) {
            CommentsService(requestProcessor: self.requestProcessor)
        }
    }
}
