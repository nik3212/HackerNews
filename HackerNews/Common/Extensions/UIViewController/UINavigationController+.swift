//
//  UINavigationController+.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return ThemeManager.shared.theme.statusBar
    }
    
    func configureDefaultNavigationBar() {
//        navigationBar.setBackgroundImage(UIImage.imageWithColor(color: .white), for: .default)
//        navigationBar.shadowImage = UIImage.imageWithColor(color: .white)
//        navigationBar.isTranslucent = false
        navigationBar.backgroundColor = .white
//        navigationBar.backIndicatorImage = R.image.backNavigation()
//        navigationBar.backIndicatorTransitionMaskImage = R.image.backNavigation()
//        navigationBar.titleTextAttributes = [.foregroundColor: .black,
//                                             .font: FontStyle.header4.font()]
        navigationBar.barTintColor = UIColor.white
        navigationBar.tintColor = UIColor.black
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.title = " "
    }
}
