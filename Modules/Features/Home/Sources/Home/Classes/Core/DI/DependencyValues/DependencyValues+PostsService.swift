//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import AppUtils
import ComposableArchitecture

extension DependencyValues {
    var postsService: IPostsService {
        get { self[PostsServiceKey.self] }
        set { self[PostsServiceKey.self] = newValue }
    }
}

// MARK: - PostsServiceKey

private enum PostsServiceKey: DependencyKey {
    static var liveValue: IPostsService = Locator.shared.resolve()
}
