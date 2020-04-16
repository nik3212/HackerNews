//
//  MainTabBarPresenter.swift
//  HackerNews
//
//  Created by Никита Васильев on 16.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

final class MainTabBarPresenter {
    // MARK: Public Properties
    weak var view: MainTabBarViewInput?
    var themeManager: ThemeManagerProtocol?
}

// MARK: MainTabBarViewOutput
extension MainTabBarPresenter: MainTabBarViewOutput {
    func viewIsReady() {
        themeManager?.addObserver(self)
    }
}

// MARK: ThemeObserver
extension MainTabBarPresenter: ThemeObserver {
    func themeDidChange(_ theme: Theme) {
        view?.update(theme: theme)
    }
}
