//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

enum PostType: Int, CaseIterable, Identifiable {
    case top
    case new
    case best
    case ask
    case show
    case jobs

    var title: String {
        switch self {
        case .new:
            return "New"
        case .best:
            return "Best"
        case .top:
            return "Top"
        case .ask:
            return "Ask"
        case .show:
            return "Show"
        case .jobs:
            return "Jobs"
        }
    }

    var systemName: String {
        switch self {
        case .new:
            return "sun.min.fill"
        case .best:
            return "star.fill"
        case .top:
            return "square.stack.3d.up.fill"
        case .ask:
            return "brain.head.profile.fill"
        case .show:
            return "eyes.inverse"
        case .jobs:
            return "suitcase.fill"
        }
    }

    var id: Self { self }
}
