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
        container.register(StoriesConfigurator.self) { resolver in
            let parentAssembler = resolver.resolve(MainTabBarConfigurator.self)?.assembler
            return StoriesConfigurator(parentAssembler: parentAssembler.unwrap())
        }
        
        container.register(AskConfigurator.self) { resolver in
            let parentAssembler = resolver.resolve(MainTabBarConfigurator.self)?.assembler
            return AskConfigurator(parentAssembler: parentAssembler.unwrap())
        }
        
        container.register(SettingsConfigurator.self) { resolver in
            let parentAssembler = resolver.resolve(MainTabBarConfigurator.self)?.assembler
            return SettingsConfigurator(parentAssembler: parentAssembler.unwrap())
        }
        
        container.register(MainTabBarPresenter.self) { resolver in
            let presenter = MainTabBarPresenter()

            presenter.themeManager = resolver.resolve(ThemeManager.self)
            
            return presenter
        }.initCompleted { resolver, presenter in
            presenter.view = resolver.resolve(MainTabBarViewController.self)
        }
        
        container.register(MainTabBarViewController.self) { resolver in
            let storiesViewController = resolver.resolve(StoriesConfigurator.self).unwrap().configureViewController()
            let askViewController = resolver.resolve(AskConfigurator.self).unwrap().configureViewController()
            let settingsViewController = resolver.resolve(SettingsConfigurator.self).unwrap().configureViewController()
            
            let theme = resolver.resolve(ThemeManager.self).unwrap().theme
            let output = resolver.resolve(MainTabBarPresenter.self).unwrap()
            
            let viewController = MainTabBarViewController(theme: theme, output: output)
            
            viewController.viewControllers = [storiesViewController, askViewController, settingsViewController]
            
            return viewController
        }
    }
}
