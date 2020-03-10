//
//  MainTabBarConfigurator.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

final class MainTabBarConfigurator {
    
    // MARK: Public Methods
    func configure() -> MainTabBarViewController {
        let modules: [TabBarViewProtocol] = [StoriesAssembler()]
        let mainTabBarVC = MainTabBarViewController()
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
