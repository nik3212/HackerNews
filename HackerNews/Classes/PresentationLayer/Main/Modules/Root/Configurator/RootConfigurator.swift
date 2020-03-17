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
    private let assembler: Assembler
    
    // MARK: Intialization
    init(parentAssembler: Assembler) {
        assembler = Assembler([RootModuleAssembly()], parent: parentAssembler)
    }
    
    // MARK: Public Methods
    func installIntoWindow(_ window: UIWindow) {
        let mainTabBarController = MainTabBarConfigurator(parentAssembler: assembler).configure()
        let secondViewController = UIViewController()
        
        if let viewController = assembler.resolver.resolve(UISplitViewController.self, arguments: mainTabBarController, secondViewController) {
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
    }
}
