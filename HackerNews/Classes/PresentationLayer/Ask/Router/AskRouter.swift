//
//  AskRouter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import struct HNService.PostModel

final class AskRouter {
    weak var transitionHandler: TransitionHandler?
    var commentsConfigurator: CommentsConfigurator?
}

// MARK: AskRouterInput
extension AskRouter: AskRouterInput {
    func openCommentsModule(for post: PostModel) {
        transitionHandler?.openModule({ [weak self] viewController in
            guard let commentsViewController = self?.commentsConfigurator?.configure(post: post) else { return }

            let nv = UINavigationController(rootViewController: commentsViewController)
            viewController.showDetailViewController(nv, sender: nil)
        })
    }
}
