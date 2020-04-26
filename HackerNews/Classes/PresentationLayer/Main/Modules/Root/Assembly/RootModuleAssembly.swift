//
//  RootModuleAssembly.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Swinject

final class RootModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RootSplitViewController.self) { (resolver, firstVC: MainTabBarViewController, secondVC: UIViewController) in
            let splitViewController = RootSplitViewController()
            splitViewController.output = resolver.resolve(RootPresenter.self, argument: splitViewController)
            
            splitViewController.viewControllers = [firstVC, secondVC]
            splitViewController.preferredPrimaryColumnWidthFraction = 1 / 3

            return splitViewController
        }
        
        container.register(MainTabBarConfigurator.self) { resolver in
            let parentAssembler = resolver.resolve(RootConfigurator.self)?.assembler
            return MainTabBarConfigurator(parentAssembler: parentAssembler.unwrap())
        }
        
        container.register(CommentsConfigurator.self) { resolver in
            let parentAssembler = resolver.resolve(RootConfigurator.self)?.assembler
            return CommentsConfigurator(parentAssembler: parentAssembler.unwrap())
        }
        
        container.register(RootPresenter.self) { (resolver, viewController: RootSplitViewController) in
            let themeManager = resolver.resolve(ThemeManager.self).unwrap()
            let presenter = RootPresenter(view: viewController, themeManager: themeManager)
            return presenter
        }
    }
}
