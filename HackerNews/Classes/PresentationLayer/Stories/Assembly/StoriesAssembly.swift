//
//  StoriesAssembly.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Swinject

final class StoriesModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(StoriesInteractor.self) { (_, presenter: StoriesPresenter) in 
            let interactor = StoriesInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(StoriesRouter.self) { (_, viewController: StoriesViewController) in
            let router = StoriesRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(StoriesPresenter.self) { (resolver, viewController: StoriesViewController) in
            let presenter = StoriesPresenter()

            presenter.view = viewController
            presenter.interactor = resolver.resolve(StoriesInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(StoriesRouter.self, argument: viewController)

            return presenter
        }

        container.register(StoriesViewController.self) { resolver in
            let viewController = R.storyboard.stories.storiesViewController()
            viewController?.output = resolver.resolve(StoriesPresenter.self, argument: viewController!)
            return viewController!
        }
    }
}
