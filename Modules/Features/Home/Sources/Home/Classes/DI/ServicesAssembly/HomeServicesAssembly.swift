//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import AppUtils
import Foundation
import NetworkLayerInterfaces

// MARK: - IHomeServicesAssembly

protocol IHomeServicesAssembly {
    var newsService: INewsService { get }
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

    var newsService: INewsService {
        resolve(INewsService.self) {
            NewsService(requestProcessor: self.requestProcessor)
        }
    }
}
