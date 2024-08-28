//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation

extension DependencyValues {
    var postsViewModelFactory: IPostViewModelFactory {
        get { self[PostViewModelFactoryKey.self] }
        set { self[PostViewModelFactoryKey.self] = newValue }
    }
}

// MARK: - PostViewModelFactoryKey

private enum PostViewModelFactoryKey: DependencyKey {
    static var liveValue: IPostViewModelFactory = PostViewModelFactory(dateTimeFormatter: RelativeDateTimeFormatter())
}
