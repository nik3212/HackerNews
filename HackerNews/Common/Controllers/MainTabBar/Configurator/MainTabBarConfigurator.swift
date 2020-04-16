//
//  MainTabBarConfigurator.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import Swinject

final class MainTabBarConfigurator {
    
    // MARK: Private Properties
    let assembler: Assembler
    
    // MARK: Initialization
    init(parentAssembler: Assembler) {
        assembler = Assembler([MainTabBarModuleAssembly()], parent: parentAssembler)
    }
    
    // MARK: Public Methods
    func configure() -> MainTabBarViewController {
        let modules: [TabBarViewProtocol] = [StoriesConfigurator(parentAssembler: assembler),
                                             SettingsConfigurator(parentAssembler: assembler)]
        let mainTabBarVC = MainTabBarViewController()
        mainTabBarVC.theme = ThemeManager.shared.theme
        var viewControllers: [UIViewController] = []
        
        for module in modules {
            viewControllers.append(setupPageController(module: module))
        }
        
        mainTabBarVC.viewControllers = viewControllers
        
        return mainTabBarVC
    }
    
    // MARK: Private Methods
    fileprivate func setupPageController(module: TabBarViewProtocol) -> UIViewController {
        let item = UITabBarItem()
        item.image = module.icon
        item.title = module.title
        
        let controller = module.configureViewController()
        controller.tabBarItem = item
        controller.title = item.title

        return controller
    }
}
