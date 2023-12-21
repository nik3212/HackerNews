//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import HomeInterfaces
import SwiftUI
import UIExtensions

// MARK: - IRootTabBarAssembly

protocol IRootTabBarAssembly {
    func assemble() -> AnyView
}

// MARK: - RootTabBarAssembly

final class RootTabBarAssembly: IRootTabBarAssembly {
    // MARK: Private

    private let homePublicAssembly: IHomePublicAssembly

    private lazy var store: Store = {
        Store(
            initialState: RootTabBarViewStore.State(tabs: [.home, .search, .settings], tab: .home)
        ) {
            RootTabBarViewStore()
        }
    }()

    // MARK: Initialization

    init(homePublicAssembly: IHomePublicAssembly) {
        self.homePublicAssembly = homePublicAssembly
    }

    // MARK: IRootTabBarAssembly

    func assemble() -> AnyView {
        RootTabBarView(
            store: store,
            viewFactory: RootTabBarViewFactory(
                homePublicAssembly: homePublicAssembly
            )
        ).eraseToAnyView()
    }
}
