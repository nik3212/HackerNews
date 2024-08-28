//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation
import HackerNewsLocalization

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
            return L10n.PostType.new
        case .best:
            return L10n.PostType.best
        case .top:
            return L10n.PostType.top
        case .ask:
            return L10n.PostType.ask
        case .show:
            return L10n.PostType.show
        case .jobs:
            return L10n.PostType.jobs
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
