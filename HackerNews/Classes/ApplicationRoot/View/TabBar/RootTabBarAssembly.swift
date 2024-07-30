//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import HomeInterfaces
import SettingsInterfaces
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
    private let settingsPublicAssembly: ISettingsPublicAssembly

    private lazy var store: Store = .init(
        initialState: RootTabBarViewStore.State(tabs: [.home, .settings], tab: .home)
    ) {
        RootTabBarViewStore()
    }

    // MARK: Initialization

    init(homePublicAssembly: IHomePublicAssembly, settingsPublicAssembly: ISettingsPublicAssembly) {
        self.homePublicAssembly = homePublicAssembly
        self.settingsPublicAssembly = settingsPublicAssembly
    }

    // MARK: IRootTabBarAssembly

    func assemble() -> AnyView {
        RootTabBarView(
            store: store,
            viewFactory: RootTabBarViewFactory(
                homePublicAssembly: homePublicAssembly,
                settingsPublicAssembly: settingsPublicAssembly
            )
        ).eraseToAnyView()
    }
}
