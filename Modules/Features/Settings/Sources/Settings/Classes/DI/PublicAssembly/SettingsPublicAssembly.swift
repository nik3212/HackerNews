//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SettingsInterfaces
import SwiftUI

public final class SettingsPublicAssembly: ISettingsPublicAssembly {
    public init() {}

    public func assemble() -> AnyView {
        AnyView(RootSettingsView())
    }
}
