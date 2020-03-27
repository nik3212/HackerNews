//
//  ThemePresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 27/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class ThemePresenter {
    // MARK: Public Properties
    weak var view: ThemeViewInput!
    var interactor: ThemeInteractorInput!
    var router: ThemeRouterInput!
}

// MARK: ThemeViewOutput
extension ThemePresenter: ThemeViewOutput {
    func viewIsReady() {
        view.setupInitialState()
    }
}

// MARK: ThemeInteractorOutput
extension ThemePresenter: ThemeInteractorOutput {

}

// MARK: ThemeModuleInput
extension ThemePresenter: ThemeModuleInput {
    func present(from viewController: UIViewController) {
        view.present(from: viewController)
    }
}
