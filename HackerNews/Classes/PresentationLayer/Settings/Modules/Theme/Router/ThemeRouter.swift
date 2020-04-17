//
//  ThemeRouter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 27/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class ThemeRouter {
    weak var transitionHandler: TransitionHandler?
}

// MARK: ThemeRouterInput
extension ThemeRouter: ThemeRouterInput {
    func dismiss() {
        transitionHandler?.openModule({ viewController in
            viewController.navigationController?.popViewController(animated: true)
        })
    }
}
