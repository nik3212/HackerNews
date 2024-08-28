//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import AppUtils
import ComposableArchitecture

extension DependencyValues {
    var commentsPager: ICommentsPager {
        get { self[CommentsPagerKey.self] }
        set { self[CommentsPagerKey.self] = newValue }
    }
}

// MARK: - CommentsPagerKey

private enum CommentsPagerKey: DependencyKey {
    static var liveValue: ICommentsPager = Locator.shared.resolve()
}
