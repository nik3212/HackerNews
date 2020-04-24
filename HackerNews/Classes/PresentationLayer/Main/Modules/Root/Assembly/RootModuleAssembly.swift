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
        container.register(RootSplitViewController.self) { (resolver, firstVC: MainTabBarViewController, secondVC: UINavigationController) in
            let splitViewController = RootSplitViewController()
            splitViewController.output = resolver.resolve(RootPresenter.self, argument: splitViewController)
            
            splitViewController.viewControllers = [firstVC, secondVC]
            //splitViewController.preferredPrimaryColumnWidthFraction = 2 / 3
            //splitViewController.preferredDisplayMode = .primaryOverlay
            
            return splitViewController
        }
        
        container.register(RootRouter.self) { (_, viewController: RootSplitViewController) in
            let router = RootRouter()
            router.transitionHandler = viewController
            return router
        }
        
        container.register(MainTabBarConfigurator.self) { resolver in
            let parentAssembler = resolver.resolve(RootConfigurator.self)?.assembler
            return MainTabBarConfigurator(parentAssembler: parentAssembler.unwrap())
        }
        
        container.register(PostViewerConfigurator.self) { resolver in
            let parentAssembler = resolver.resolve(RootConfigurator.self)?.assembler
            return PostViewerConfigurator(parentAssembler: parentAssembler.unwrap())
        }
        
        container.register(RootPresenter.self) { (resolver, viewController: RootSplitViewController) in
            let themeManager = resolver.resolve(ThemeManager.self).unwrap()
            let presenter = RootPresenter(view: viewController, themeManager: themeManager)
            return presenter
        }
    }
}
