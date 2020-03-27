//
//  MainTabBarModuleAssembly.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Swinject

final class MainTabBarModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SettingsConfigurator.self) { resolver in
            let parentAssembler = resolver.resolve(MainTabBarConfigurator.self)?.assembler
            return SettingsConfigurator(parentAssembler: parentAssembler!)
        }
    }
}
