//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import AppUtils
import ComposableArchitecture

extension DependencyValues {
    var postsPager: PostsPager {
        get { self[PostsPagerKey.self] }
        set { self[PostsPagerKey.self] = newValue }
    }
}

// MARK: - PostsPagerKey

private enum PostsPagerKey: DependencyKey {
    static var liveValue: PostsPager = Locator.shared.resolve()
}
