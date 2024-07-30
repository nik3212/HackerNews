//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import HomeInterfaces
import SettingsInterfaces
import SwiftUI

struct RootTabBarViewFactory {
    // MARK: Properties

    private let homePublicAssembly: IHomePublicAssembly
    private let settingsPublicAssembly: ISettingsPublicAssembly

    // MARK: Initialization

    init(homePublicAssembly: IHomePublicAssembly, settingsPublicAssembly: ISettingsPublicAssembly) {
        self.homePublicAssembly = homePublicAssembly
        self.settingsPublicAssembly = settingsPublicAssembly
    }

    // MARK: Internal

    func view(for tab: Tab) -> some View {
        switch tab {
        case .home:
            return homePublicAssembly.assemble()
        case .settings:
            return settingsPublicAssembly.assemble()
        }
    }
}
