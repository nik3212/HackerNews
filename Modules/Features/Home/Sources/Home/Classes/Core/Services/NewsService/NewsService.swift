//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation
import NetworkLayerInterfaces

// MARK: - NewsService

final class NewsService {
    // MARK: Private

    private let requestProcessor: IRequestProcessor

    // MARK: Initialization

    init(requestProcessor: IRequestProcessor) {
        self.requestProcessor = requestProcessor
    }
}

// MARK: INewsService

extension NewsService: INewsService {
    func loadNews(ids _: [Int]) async throws -> [News] {
        []
    }
}
