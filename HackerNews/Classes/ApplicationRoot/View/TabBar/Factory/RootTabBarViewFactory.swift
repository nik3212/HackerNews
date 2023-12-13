//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import SwiftUI

struct RootTabBarViewFactory {
    func view(for tab: Tab) -> some View {
        switch tab {
        case .home:
            return Label(title: { Text("HOME") }, icon: {})
        case .settings:
            return Label(title: { Text("SETTING") }, icon: {})
        case .search:
            return Label(title: { Text("SEARCH") }, icon: {})
        }
    }
}
