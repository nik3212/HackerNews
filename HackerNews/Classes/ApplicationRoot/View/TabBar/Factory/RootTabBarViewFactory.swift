//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import HomeInterfaces
import SwiftUI

struct RootTabBarViewFactory {
    // MARK: Properties

    private let homePublicAssembly: IHomePublicAssembly

    // MARK: Initialization

    init(homePublicAssembly: IHomePublicAssembly) {
        self.homePublicAssembly = homePublicAssembly
    }

    // MARK: Internal

    func view(for tab: Tab) -> some View {
        switch tab {
        case .home:
            return homePublicAssembly.assemble()
        case .settings:
            return AnyView(Label(title: { Text("SETTING") }, icon: {}))
        case .search:
            return AnyView(Label(title: { Text("SEARCH") }, icon: {}))
        }
    }
}
