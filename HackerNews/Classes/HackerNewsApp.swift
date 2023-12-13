//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

@main
struct HackerNewsApp: App {
    static let store = Store(
        initialState: RootTabBarViewStore.State(tabs: [.home, .search, .settings], tab: .home)
    ) {
        RootTabBarViewStore()
    }

    var body: some Scene {
        WindowGroup {
            RootTabBarView(
                store: Self.store,
                viewFactory: RootTabBarViewFactory()
            )
        }
    }
}
