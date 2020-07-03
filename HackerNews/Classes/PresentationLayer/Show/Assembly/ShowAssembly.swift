//
//  ShowAssembly.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Swinject
import HNService

final class ShowModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ShowInteractor.self) { (resolver, presenter: ShowPresenter) in
            let interactor = ShowInteractor()
            interactor.output = presenter
            interactor.networkService = resolver.resolve(HNServiceProtocol.self)
            return interactor
        }

        container.register(ShowRouter.self) { (resolver, viewController: PostsViewController) in
            let router = ShowRouter()
            router.transitionHandler = viewController
            router.commentsConfigurator = resolver.resolve(CommentsConfigurator.self)
            return router
        }

        container.register(ShowPresenter.self) { (resolver, viewController: PostsViewController) in
            let presenter = ShowPresenter()

            presenter.view = viewController
            presenter.interactor = resolver.resolve(ShowInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(ShowRouter.self, argument: viewController)
            presenter.themeManager = resolver.resolve(ThemeManager.self)
            
            return presenter
        }

        container.register(PostsViewController.self, name: "ShowVC") { resolver in
            let viewController = PostsViewController()
            viewController.output = resolver.resolve(ShowPresenter.self, argument: viewController)
            return viewController
        }.inObjectScope(.transient)
    }
}
