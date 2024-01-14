//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import AppUtils
import ComposableArchitecture
import SwiftUI

// MARK: - INavigationTitleAssembly

protocol INavigationTitleAssembly {
    func assemble() -> AnyView
}

// MARK: - NavigationTitleAssembly

final class NavigationTitleAssembly: INavigationTitleAssembly {
    // MARK: Properties

    private let appNameProvider: IAppNameProvider

    private lazy var store: StoreOf<NavigationTitleViewStore> = {
        Store(initialState: NavigationTitleViewStore.State(date: "", appName: "")) {
            NavigationTitleViewStore(
                appNameProvider: self.appNameProvider,
                dateFormatter: DateFormatter.EEEEMMMd
            )
        }
    }()

    // MARK: Initialization

    init(appNameProvider: IAppNameProvider) {
        self.appNameProvider = appNameProvider
    }

    // MARK: INavigationTitleAssembly

    func assemble() -> AnyView {
        NavigationTitleView(store: store).eraseToAnyView()
    }
}
