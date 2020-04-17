//
//  SettingsRouter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class SettingsRouter {
    // MARK: Public Properties
    weak var transitionHandler: TransitionHandler?
    var themeConfigurator: ThemeConfigurator?
}

// MARK: SettingsRouterInput
extension SettingsRouter: SettingsRouterInput {
    func showThemeModule() {
        transitionHandler?.openModule({ viewController in
            self.themeConfigurator?.configure()?.present(from: viewController)
        })
    }
    
    func openURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
}
