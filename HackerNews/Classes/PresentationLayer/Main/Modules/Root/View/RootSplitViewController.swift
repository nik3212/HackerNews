//
//  RootSplitViewController.swift
//  HackerNews
//
//  Created by Никита Васильев on 17.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

class RootSplitViewController: UISplitViewController {
    
    // MARK: Public Properties
    var output: RootViewOutput!
    
    // MARK: Private Properties
    private var statusBarStyle: UIStatusBarStyle = .default
    private var theme: Theme?
    
    // MARK: Override Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredDisplayMode = .allVisible
        delegate = self
        output.viewIsReady()
    }
}

// MARK: RootViewInput
extension RootSplitViewController: RootViewInput {
    func setupInitialState(theme: Theme) {
        self.theme = theme
        update(theme: theme)
    }
}

// MARK: ThemeUpdatable
extension RootSplitViewController: ThemeUpdatable {
    func update(theme: Theme) {
        self.theme = theme
        theme.view.apply(to: view)
        statusBarStyle = theme.statusBar
        setNeedsStatusBarAppearanceUpdate()
    }
}

extension RootSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        if let tabController = splitViewController.viewControllers[0] as? MainTabBarViewController {
            if splitViewController.traitCollection.horizontalSizeClass == .compact {
                if let navController = vc as? UINavigationController, let actualVC = navController.topViewController {
                    tabController.selectedViewController?.show(actualVC, sender: sender)
                    navController.popViewController(animated: false)
                } else {
                    tabController.selectedViewController?.show(vc, sender: sender)
                }
            } else {
                splitViewController.viewControllers = [tabController, vc]
            }
        }
        return true
    }
}
