//
//  CommentsAssembly.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Swinject

final class CommentsModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CommentsInteractor.self) { (resolver, presenter: CommentsPresenter) in
            let interactor = CommentsInteractor()
            interactor.output = presenter
            interactor.networkService = resolver.resolve(HNServiceProtocol.self)
            return interactor
        }

        container.register(CommentsRouter.self) { (_, viewController: CommentsViewController) in
            let router = CommentsRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(CommentsModuleInput.self) { (resolver, viewController: CommentsViewController, post: PostModel) in
            let presenter = CommentsPresenter()

            presenter.view = viewController
            presenter.interactor = resolver.resolve(CommentsInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(CommentsRouter.self, argument: viewController)
            presenter.themeManager = resolver.resolve(ThemeManager.self)
            presenter.post = post
            return presenter
        }

        container.register(CommentsViewController.self) { (resolver, post: PostModel) in
            let viewController = R.storyboard.comments().instantiateViewController(type: CommentsViewController.self)
            viewController.output = resolver.resolve(CommentsModuleInput.self, arguments: viewController, post) as? CommentsPresenter
            return viewController
        }
    }
}
