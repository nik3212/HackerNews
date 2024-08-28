//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation
import HackerNewsLocalization

enum Tab: Int, Identifiable {
    case home
    case settings

    var id: Self { self }

    var name: String {
        switch self {
        case .home:
            return L10n.TabBar.Item.home
        case .settings:
            return L10n.TabBar.Item.settings
        }
    }

    var iconSystemName: String {
        switch self {
        case .home:
            return "house"
        case .settings:
            return "gearshape"
        }
    }
}
