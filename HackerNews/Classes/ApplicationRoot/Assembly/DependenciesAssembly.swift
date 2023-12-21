//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Home
import HomeInterfaces
import NetworkLayer
import NetworkLayerInterfaces

// MARK: - IDependenciesAssembly

protocol IDependenciesAssembly {
    var homePublicAssembly: IHomePublicAssembly { get }
    var networkAssembly: INetworkLayerAssembly { get }
}

// MARK: - DependenciesAssembly

final class DependenciesAssembly: IDependenciesAssembly {
    var homePublicAssembly: IHomePublicAssembly {
        HomePublicAssembly(requestProcessor: networkAssembly.assemble())
    }

    var networkAssembly: INetworkLayerAssembly {
        NetworkLayerAssembly()
    }
}
