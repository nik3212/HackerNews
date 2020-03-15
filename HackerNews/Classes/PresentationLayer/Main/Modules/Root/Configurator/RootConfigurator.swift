//
//  RootConfigurator.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

final class RootConfigurator {
    func installIntoWindow(_ window: UIWindow) {
        let splitViewController = UISplitViewController()
        
        let firstViewController = MainTabBarConfigurator().configure()

        let secondViewController = UIViewController()
        let navigationSecondViewController = UINavigationController(rootViewController: secondViewController)
        
        splitViewController.viewControllers = [firstViewController, navigationSecondViewController]
        splitViewController.preferredPrimaryColumnWidthFraction = 1 / 3
        splitViewController.preferredDisplayMode = .primaryOverlay
        
        window.rootViewController = splitViewController
        
        window.makeKeyAndVisible()
    }
}
