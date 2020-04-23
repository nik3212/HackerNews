//
//  StoriesRouter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation

class StoriesRouter {
    // MARK: Public Properties
    weak var transitionHandler: TransitionHandler?
}

// MARK: StoriesRouterInput
extension StoriesRouter: StoriesRouterInput {
    func openFilterModule(with models: [AlertActionModel]) {
        transitionHandler?.openModule({ viewController in
            viewController.showActionSheet(actions: models)
        })
    }
}
