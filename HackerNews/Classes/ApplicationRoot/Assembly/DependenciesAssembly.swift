//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Home
import HomeInterfaces
import NetworkLayer
import NetworkLayerInterfaces
import Settings
import SettingsInterfaces

// MARK: - IDependenciesAssembly

protocol IDependenciesAssembly {
    var homePublicAssembly: IHomePublicAssembly { get }
    var settingsPublicAssembly: ISettingsPublicAssembly { get }
    var networkAssembly: INetworkLayerAssembly { get }
}

// MARK: - DependenciesAssembly

final class DependenciesAssembly: IDependenciesAssembly {
    var homePublicAssembly: IHomePublicAssembly {
        HomePublicAssembly(requestProcessor: networkAssembly.assemble(), settingsAssembly: settingsPublicAssembly)
    }

    var networkAssembly: INetworkLayerAssembly {
        NetworkLayerAssembly()
    }

    var settingsPublicAssembly: ISettingsPublicAssembly {
        SettingsPublicAssembly()
    }
}
