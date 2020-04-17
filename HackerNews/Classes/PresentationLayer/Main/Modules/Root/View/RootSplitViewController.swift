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
    var theme: Theme!
    var output: RootViewOutput!
    
    // MARK: Private Properties
    private var statusBarStyle: UIStatusBarStyle = .default

    // MARK: Override Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        update(theme: theme)
        output.viewIsReady()
    }
}

// MARK: RootViewInput
extension RootSplitViewController: RootViewInput { }

// MARK: ThemeUpdatable
extension RootSplitViewController: ThemeUpdatable {
    func update(theme: Theme) {
        theme.view.apply(to: view)
        statusBarStyle = theme.statusBar
        setNeedsStatusBarAppearanceUpdate()
    }
}
