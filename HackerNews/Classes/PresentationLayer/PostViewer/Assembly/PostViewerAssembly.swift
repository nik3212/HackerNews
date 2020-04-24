//
//  PostViewerAssembly.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 23/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Swinject

final class PostViewerModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PostViewerInteractor.self) { (_, presenter: PostViewerPresenter) in 
            let interactor = PostViewerInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(PostViewerRouter.self) { (_, viewController: PostViewerViewController) in
            let router = PostViewerRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(PostViewerModuleInput.self) { (resolver, viewController: PostViewerViewController) in
            let presenter = PostViewerPresenter()

            presenter.view = viewController
            presenter.interactor = resolver.resolve(PostViewerInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(PostViewerRouter.self, argument: viewController)

            return presenter
        }

        container.register(PostViewerViewController.self) { resolver in
            let viewController = R.storyboard.postViewer().instantiateViewController(type: PostViewerViewController.self)
            viewController.output = resolver.resolve(PostViewerModuleInput.self, argument: viewController) as? PostViewerPresenter
            return viewController
        }
    }
}
