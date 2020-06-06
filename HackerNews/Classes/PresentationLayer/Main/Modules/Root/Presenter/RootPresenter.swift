//
//  RootPresenter.swift
//  HackerNews
//
//  Created by Никита Васильев on 17.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

final class RootPresenter {
    // MARK: Private Properties
    unowned let view: RootViewInput
    let themeManager: ThemeManagerProtocol
    
    // MARK: Initialization
    init(view: RootViewInput, themeManager: ThemeManagerProtocol) {
        self.view = view
        self.themeManager = themeManager
    }
}

// MARK: RootViewOutput
extension RootPresenter: RootViewOutput {
    func viewIsReady() {
        view.setupInitialState(theme: themeManager.theme)
        themeManager.addObserver(self)
    }
}

// MARK: ThemeObserver
extension RootPresenter: ThemeObserver {
    func themeDidChange(_ theme: Theme) {
        view.update(theme: theme)
    }
}
