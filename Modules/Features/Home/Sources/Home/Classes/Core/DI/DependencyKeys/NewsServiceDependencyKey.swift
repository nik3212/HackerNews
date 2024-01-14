//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import AppUtils
import Dependencies

// MARK: - NewsServiceDependencyKey

// FIXME: - Register this dependency in the `Locator`
struct NewsServiceDependencyKey: DependencyKey {
    static var liveValue: IPostsService = Locator.shared.resolve()
    static var previewValue: IPostsService = Locator.shared.resolve()
}

extension DependencyValues {
    var newsService: IPostsService {
        get { self[NewsServiceDependencyKey.self] }
        set { self[NewsServiceDependencyKey.self] = newValue }
    }
}
