//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

// MARK: - IRootSettingsAssembly

protocol IRootSettingsAssembly {
    func assemble() -> AnyView
}

// MARK: - RootSettingsAssembly

final class RootSettingsAssembly: IRootSettingsAssembly {
    private lazy var store: StoreOf<RootSettingsFeature> = Store(
        initialState: RootSettingsFeature.State(isEmailSheetPresented: false)
    ) {
        RootSettingsFeature()
    }

    func assemble() -> AnyView {
        AnyView(RootSettingsView(store: store))
    }
}
