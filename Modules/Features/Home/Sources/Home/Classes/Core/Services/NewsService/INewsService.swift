//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation

protocol INewsService {
    func loadNews(ids: [Int]) async throws -> [News]
}
