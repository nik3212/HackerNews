//
//  SettingsPresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class SettingsPresenter {
    // MARK: Public Properties
    weak var view: SettingsViewInput!
    var interactor: SettingsInteractorInput!
    var router: SettingsRouterInput!
    
    // MARK: Private Properties
    private var cells: [[SettingsCellModel]] = [
        [SettingsCellModel(icon: R.image.themeIcon(), title: "Theme", type: .themes)]
    ]
    
    enum Section: String {
        case theme = "Theme"
    }
}

// MARK: SettingsViewOutput
extension SettingsPresenter: SettingsViewOutput {
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func getNumberOfRows(in section: Int) -> Int {
        return cells[section].count
    }
    
    func getNumberOfSections() -> Int {
        return cells.count
    }
    
    func getTitleForHeader(in section: Int) -> String {
        return Section.theme.rawValue
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let cell = cells[indexPath.section][indexPath.row]
        
        switch cell.type {
        case .themes:
            router.showThemeModule()
        }
    }
    
    func getModel(for indexPath: IndexPath) -> SettingsCellModel {
        return cells[indexPath.section][indexPath.row]
    }
}

// MARK: SettingsInteractorOutput
extension SettingsPresenter: SettingsInteractorOutput {

}
