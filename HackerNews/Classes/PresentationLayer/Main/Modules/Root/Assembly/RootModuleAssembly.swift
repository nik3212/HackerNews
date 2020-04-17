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
        container.register(UISplitViewController.self) { (_, firstVC: MainTabBarViewController, secondVC: UIViewController) in
            let splitViewController = UISplitViewController()
            let navigationSecondViewController = UINavigationController(rootViewController: secondVC)
    
            splitViewController.viewControllers = [firstVC, navigationSecondViewController]
            splitViewController.preferredPrimaryColumnWidthFraction = 1 / 3
            splitViewController.preferredDisplayMode = .primaryOverlay
            
            return splitViewController
        }
        
        container.register(MainTabBarConfigurator.self) { resolver in
            let parentAssembler = resolver.resolve(RootConfigurator.self)?.assembler
            return MainTabBarConfigurator(parentAssembler: parentAssembler.unwrap())
        }
    }
}
