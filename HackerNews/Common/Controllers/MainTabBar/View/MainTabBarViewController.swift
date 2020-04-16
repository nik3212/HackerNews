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
    var theme: Theme!
    
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: ThemeUpdatable
extension MainTabBarViewController: ThemeUpdatable {
    func update(theme: Theme) {
        theme.tabBar.apply(to: self.tabBar)
    }
}
