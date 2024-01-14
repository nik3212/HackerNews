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
}
