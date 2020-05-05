//
//  ShowRouter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation

final class ShowRouter {
    weak var transitionHandler: TransitionHandler?
    var commentsConfigurator: CommentsConfigurator?
}

// MARK: ShowRouterInput
extension ShowRouter: ShowRouterInput {
    func openCommentsModule(for post: PostModel) {
        transitionHandler?.openModule({ [weak self] viewController in
            self?.commentsConfigurator?.configure(post: post)?.present(from: viewController)
        })
    }
}
