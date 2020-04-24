//
//  RootConfigurator.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import Swinject

final class RootConfigurator {
    
    // MARK: Private Properties
    let assembler: Assembler
    
    // MARK: Intialization
    init(parentAssembler: Assembler) {
        assembler = Assembler([RootModuleAssembly()], parent: parentAssembler)
    }
    
    // MARK: Public Methods
    func installIntoWindow(_ window: UIWindow) {
        let mainTabBarController = MainTabBarConfigurator(parentAssembler: assembler).configure()
        let secondViewController = UINavigationController(rootViewController: mainTabBarController)//PostViewerConfigurator(parentAssembler: assembler).configure()
        
        if let viewController = assembler.resolver.resolve(RootSplitViewController.self, arguments: mainTabBarController, secondViewController) {
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
    }
}
