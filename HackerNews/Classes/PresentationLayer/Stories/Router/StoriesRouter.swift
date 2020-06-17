//
//  StoriesRouter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import SafariServices
import struct HNService.PostModel

class StoriesRouter {
    // MARK: Public Properties
    weak var transitionHandler: TransitionHandler?
    var commentsConfigurator: CommentsConfigurator?
}

// MARK: StoriesRouterInput
extension StoriesRouter: StoriesRouterInput {
    func openFilterModule(with models: [AlertActionModel]) {
        transitionHandler?.openModule({ viewController in
            viewController.showActionSheet(actions: models)
        })
    }
    
    func openCommentsModule(for post: PostModel) {
        transitionHandler?.openModule({ [weak self] viewController in
            guard let commentsViewController = self?.commentsConfigurator?.configure(post: post) else { return }

            let nv = UINavigationController(rootViewController: commentsViewController)
            viewController.showDetailViewController(nv, sender: nil)
        })
    }
    
    func openStories(from url: String) {
        transitionHandler?.openModule({ viewController in
            guard let url = URL(string: url) else { return }
            let safariVC = SFSafariViewController(url: url)
            viewController.present(safariVC, animated: true, completion: nil)
        })
    }
}
