//
//  BaseNavigationController.swift
//  HackerNews
//
//  Created by Никита Васильев on 16.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ThemeManager.shared.addObserver(self)
        themeDidChange(ThemeManager.shared.theme)
    }
}

extension BaseNavigationController: ThemeObserver {
    func themeDidChange(_ theme: Theme) {

        theme.navigationBar.apply(to: self.navigationBar)
        theme.view.apply(to: view)
        
        //        theme.view.apply(to: navigationController!.view)
        //        theme.navigationBar.apply(to: navigationController!.navigationBar)
    }
}
