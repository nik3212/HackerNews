//
//  MainTabBarViewController.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    // MARK: Public Properties
    let output: MainTabBarViewOutput
    
    // MARK: Public Properties
    private(set) var theme: Theme
    
    // MARK: Initialization
    init(theme: Theme, output: MainTabBarViewOutput) {
        self.theme = theme
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        update(theme: theme)
        output.viewIsReady()
    }
}

// MARK: MainTabBarViewInput
extension MainTabBarViewController: MainTabBarViewInput { }

// MARK: ThemeUpdatable
extension MainTabBarViewController: ThemeUpdatable {
    func update(theme: Theme) {
        theme.tabBar.apply(to: self.tabBar)
        theme.view.apply(to: self.view)
        
        guard let viewControllers = viewControllers else { return }
        
        for viewController in viewControllers {
            if let navController = viewController as? UINavigationController {
                theme.navigationBar.apply(to: navController.navigationBar)
                theme.view.apply(to: navController.view)
            }
        }
    }
}
