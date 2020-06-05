//
//  MockContainer.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 05.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import Swinject

@testable import HackerNews

final class MockContainer {
    
    // MARK: Public Properties
    let container: Container
    let assembler: Assembler
    
    // MARK: Initialization
    init() {
        container = ServiceLocatorConfigurator().container
        assembler = Assembler(container: container)
        
        assembler.apply(assemblies: [
            RootModuleAssembly(),
            MainTabBarModuleAssembly(),
            SettingsModuleAssembly(),
            AskModuleAssembly(),
            StoriesModuleAssembly(),
            ShowModuleAssembly(),
            ThemeModuleAssembly(),
            ServiceLocatorAssembly(),
            CommentsModuleAssembly()
        ])
    }
}
