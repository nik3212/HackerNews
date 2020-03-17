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
    private var cells: [[Int]] = []
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
        return ""
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        
    }
}

// MARK: SettingsInteractorOutput
extension SettingsPresenter: SettingsInteractorOutput {

}
