//
//  StoriesRouter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import SafariServices

class StoriesRouter {
    // MARK: Public Properties
    weak var transitionHandler: TransitionHandler?
    var postViewer: PostViewerModuleInput?
}

// MARK: StoriesRouterInput
extension StoriesRouter: StoriesRouterInput {
    func openFilterModule(with models: [AlertActionModel]) {
        transitionHandler?.openModule({ viewController in
            viewController.showActionSheet(actions: models)
        })
    }
    
    func showPost(by url: URL) {
        transitionHandler?.openModule({ viewController in
            guard let splitViewController = viewController.splitViewController as? RootSplitViewController else { return }
            let safariViewController = SFSafariViewController(url: url)
            splitViewController.showDetailViewController(safariViewController, sender: nil)
        })
    }
}
