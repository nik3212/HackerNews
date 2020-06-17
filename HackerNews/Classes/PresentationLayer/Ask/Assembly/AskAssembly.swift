//
//  AskAssembly.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Swinject
import protocol HNService.HNServiceProtocol

final class AskModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AskInteractor.self) { (resolver, presenter: AskPresenter) in
            let interactor = AskInteractor()
            interactor.output = presenter
            interactor.networkService = resolver.resolve(HNServiceProtocol.self)
            return interactor
        }

        container.register(AskRouter.self) { (resolver, viewController: AskViewController) in
            let router = AskRouter()
            router.transitionHandler = viewController
            router.commentsConfigurator = resolver.resolve(CommentsConfigurator.self)
            return router
        }

        container.register(AskPresenter.self) { (resolver, viewController: AskViewController) in
            let presenter = AskPresenter()

            presenter.view = viewController
            presenter.interactor = resolver.resolve(AskInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(AskRouter.self, argument: viewController)
            presenter.themeManager = resolver.resolve(ThemeManager.self)
            
            return presenter
        }

        container.register(AskViewController.self) { resolver in
            let viewController = R.storyboard.ask().instantiateViewController(type: AskViewController.self)
            viewController.output = resolver.resolve(AskPresenter.self, argument: viewController)
            return viewController
        }
    }
}
