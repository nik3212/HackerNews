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
