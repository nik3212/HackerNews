//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Home
import SwiftUI

@main
struct HackerNewsApp: App {
    // MARK: Properties

    private let assembly: IApplicationAssembly = ApplicationAssembly(dependencies: DependenciesAssembly())

    // MARK: View

    var body: some Scene {
        WindowGroup {
            self.assembly.assemble()
        }
    }
}
