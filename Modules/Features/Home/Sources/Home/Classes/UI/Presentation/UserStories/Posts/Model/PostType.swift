//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

enum PostType: Int, CaseIterable, Identifiable {
    case new
    case best
    case top
    case ask
    case show

    var title: String {
        switch self {
        case .new:
            return "New Stories"
        case .best:
            return "Best Stories"
        case .top:
            return "Top Stories"
        case .ask:
            return "Ask HN"
        case .show:
            return "Show HN"
        }
    }

    var systemName: String {
        switch self {
        case .new:
            return "star.fill"
        case .best:
            return "star.fill"
        case .top:
            return "star.fill"
        case .ask:
            return "mic.fill"
        case .show:
            return "eye.fill"
        }
    }

    var id: Self { self }
}
