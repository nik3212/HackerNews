//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import ComposableArchitecture
import Home
import PulseUI
import SwiftUI
import UIExtensions

@main
struct HackerNewsApp: App {
    // MARK: Properties

    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    #if DEBUG
        @State private var showConsole = false
    #endif

    private let assembly: IApplicationAssembly = ApplicationAssembly(dependencies: DependenciesAssembly())

    // MARK: View

    var body: some Scene {
        WindowGroup {
            #if DEBUG
                assembly.assemble()
                    .sheet(isPresented: $showConsole) {
                        NavigationView {
                            ConsoleView()
                        }
                    }
                    .onShake {
                        showConsole.toggle()
                    }
            #else
                assembly.assemble()
            #endif
        }
    }
}
