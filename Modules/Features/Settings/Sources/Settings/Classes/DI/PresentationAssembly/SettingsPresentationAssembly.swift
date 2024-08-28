//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

// MARK: - ISettingsPresentationAssembly

protocol ISettingsPresentationAssembly {
    var rootSettingsAssembly: IRootSettingsAssembly { get }
}

// MARK: - SettingsPresentationAssembly

final class SettingsPresentationAssembly: ISettingsPresentationAssembly {
    var rootSettingsAssembly: any IRootSettingsAssembly {
        RootSettingsAssembly()
    }
}
