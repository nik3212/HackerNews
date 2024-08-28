//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import AppUtils
import ComposableArchitecture

extension DependencyValues {
    var repliesService: IRepliesService {
        get { self[RepliesServiceKey.self] }
        set { self[RepliesServiceKey.self] = newValue }
    }
}

// MARK: - RepliesServiceKey

private enum RepliesServiceKey: DependencyKey {
    static var liveValue: IRepliesService = Locator.shared.resolve()
}
