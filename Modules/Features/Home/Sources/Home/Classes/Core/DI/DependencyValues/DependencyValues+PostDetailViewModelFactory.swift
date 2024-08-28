//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation

// MARK: - PostDetailViewModelFactoryKey

private enum PostDetailViewModelFactoryKey: DependencyKey {
    static var liveValue: IPostDetailViewModelFactory = PostDetailViewModelFactory(dateTimeFormatter: RelativeDateTimeFormatter())
}

extension DependencyValues {
    var postDetailViewModelFactory: IPostDetailViewModelFactory {
        get { self[PostDetailViewModelFactoryKey.self] }
        set { self[PostDetailViewModelFactoryKey.self] = newValue }
    }
}
