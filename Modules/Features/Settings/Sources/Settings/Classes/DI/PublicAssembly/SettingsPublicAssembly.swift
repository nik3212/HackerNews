//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import SettingsInterfaces
import SwiftUI

public final class SettingsPublicAssembly: ISettingsPublicAssembly {
    private let presentationAssembly: ISettingsPresentationAssembly

    public init() {
        presentationAssembly = SettingsPresentationAssembly()
    }

    public func assemble() -> AnyView {
        presentationAssembly.rootSettingsAssembly.assemble()
    }
}
