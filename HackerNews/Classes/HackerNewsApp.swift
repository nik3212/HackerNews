//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
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
    @State private var showConsole = false

    private let assembly: IApplicationAssembly = ApplicationAssembly(dependencies: DependenciesAssembly())

    // MARK: View

    var body: some Scene {
        WindowGroup {
            self.assembly.assemble()
                .sheet(isPresented: $showConsole) {
                    NavigationView {
                        ConsoleView()
                    }
                }
                .onShake {
                    showConsole.toggle()
                }
        }
    }
}
