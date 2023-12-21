//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import SwiftUI

// MARK: - IApplicationAssembly

protocol IApplicationAssembly {
    func assemble() -> AnyView
}

// MARK: - ApplicationAssembly

final class ApplicationAssembly: IApplicationAssembly {
    // MARK: Properties

    private var dependencies: IDependenciesAssembly

    // MARK: Initialization

    init(dependencies: IDependenciesAssembly) {
        self.dependencies = dependencies
    }

    // MARK: IApplicationAssembly

    func assemble() -> AnyView {
        RootTabBarAssembly(homePublicAssembly: dependencies.homePublicAssembly).assemble()
    }
}
