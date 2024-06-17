//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture

// MARK: - PostDetailViewModelFactoryKey

private enum PostDetailViewModelFactoryKey: DependencyKey {
    static var liveValue: IPostDetailViewModelFactory = PostDetailViewModelFactory()
}

extension DependencyValues {
    var postDetailViewModelFactory: IPostDetailViewModelFactory {
        get { self[PostDetailViewModelFactoryKey.self] }
        set { self[PostDetailViewModelFactoryKey.self] = newValue }
    }
}
