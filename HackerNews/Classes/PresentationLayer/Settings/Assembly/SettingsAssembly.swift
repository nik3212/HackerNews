//
//  SettingsAssembly.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Swinject

final class SettingsModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SettingsInteractor.self) { (_, presenter: SettingsPresenter) in 
            let interactor = SettingsInteractor()
            interactor.output = presenter
            return interactor
        }

        container.register(SettingsRouter.self) { (_, viewController: SettingsViewController) in
            let router = SettingsRouter()
            router.transitionHandler = viewController
            return router
        }

        container.register(SettingsPresenter.self) { (resolver, viewController: SettingsViewController) in 
            let presenter = SettingsPresenter()

            presenter.view = viewController
            presenter.interactor = resolver.resolve(SettingsInteractor.self, argument: presenter)
            presenter.router = resolver.resolve(SettingsRouter.self, argument: viewController)

            return presenter
        }

        container.register(SettingsViewController.self) { resolver in
            let viewController = R.storyboard.settingsModule().instantiateViewController(type: SettingsViewController.self)
            viewController.output = resolver.resolve(SettingsPresenter.self, argument: viewController)
            return viewController
        }
    }
}
