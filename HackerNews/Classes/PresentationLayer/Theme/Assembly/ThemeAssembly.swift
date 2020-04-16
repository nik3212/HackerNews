//
//  ThemeAssembly.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 27/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Swinject

final class ThemeModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ThemeInteractor.self) { (_, presenter: ThemePresenter) in 
            let interactor = ThemeInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(ThemeRouter.self) { (_, viewController: ThemeViewController) in
            let router = ThemeRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(ThemeModuleInput.self) { (resolver, viewController: ThemeViewController) in
            let presenter = ThemePresenter()

            presenter.view = viewController
            presenter.interactor = resolver.resolve(ThemeInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(ThemeRouter.self, argument: viewController)
            presenter.themeManager = resolver.resolve(ThemeManager.self)
            
            return presenter
        }

        container.register(ThemeViewController.self) { resolver in
            let viewController = R.storyboard.theme().instantiateViewController(type: ThemeViewController.self)
            viewController.output = resolver.resolve(ThemeModuleInput.self, argument: viewController) as? ThemePresenter
            viewController.theme = resolver.resolve(ThemeManager.self)?.theme
            return viewController
        }
    }
}
