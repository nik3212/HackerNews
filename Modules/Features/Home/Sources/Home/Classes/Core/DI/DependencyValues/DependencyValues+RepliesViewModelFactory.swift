//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Foundation

extension DependencyValues {
    var repliesViewModelFactory: IRepliesViewModelFactory {
        get { self[RepliesViewModelFactoryKey.self] }
        set { self[RepliesViewModelFactoryKey.self] = newValue }
    }
}

// MARK: - RepliesViewModelFactoryKey

private enum RepliesViewModelFactoryKey: DependencyKey {
    static var liveValue: IRepliesViewModelFactory = RepliesViewModelFactory(dateTimeFormatter: RelativeDateTimeFormatter())
}
