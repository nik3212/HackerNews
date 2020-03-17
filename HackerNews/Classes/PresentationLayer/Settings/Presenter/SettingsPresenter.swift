//
//  SettingsPresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class SettingsPresenter {
    weak var view: SettingsViewInput!
    var interactor: SettingsInteractorInput!
    var router: SettingsRouterInput!
}

// MARK: SettingsViewOutput
extension SettingsPresenter: SettingsViewOutput {
    func viewIsReady() {
        view.setupInitialState()
    }
}

// MARK: SettingsInteractorOutput
extension SettingsPresenter: SettingsInteractorOutput {

}
