//
//  CommentsRouter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation
import SafariServices

class CommentsRouter {
    weak var transitionHandler: TransitionHandler?
}

// MARK: CommentsRouterInput
extension CommentsRouter: CommentsRouterInput {
    func openPost(from url: String) {
        transitionHandler?.openModule({ viewController in
            guard let url = URL(string: url) else { return }
            let safariVC = SFSafariViewController(url: url)
            viewController.present(safariVC, animated: true, completion: nil)
        })
    }
}
