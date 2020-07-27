//
//  SettingsPresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

final class SettingsPresenter {
    // MARK: Public Properties
    weak var view: SettingsViewInput!
    var interactor: SettingsInteractorInput!
    var router: SettingsRouterInput!
    var themeManager: ThemeManagerProtocol!
    
    // MARK: Private Properties
    private var cells: [SettingsListSections: [SettingsListData]] = [
        .themes: [.themes], .help: [.help, .rate]
    ]
}

// MARK: SettingsViewOutput
extension SettingsPresenter: SettingsViewOutput {
    func viewIsReady() {
        view.setupInitialState(title: Locale.title.localized(), theme: themeManager.theme)
        themeManager?.addObserver(self)
    }
    
    func getNumberOfRows(in section: Int) -> Int {
        if let tableSection = SettingsListSections(rawValue: section), let data = cells[tableSection] {
            return data.count
        }
        return 0
    }
    
    func getNumberOfSections() -> Int {
        return SettingsListSections.allCases.count
    }
    
    func getTitleForHeader(in section: Int) -> String? {
        return SettingsListSections(rawValue: section)?.title
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let section = SettingsListSections(rawValue: indexPath.section),
            let cellsData = cells[section] else {
            return
        }
        
        let cell = cellsData[indexPath.row]
        
        switch cell {
        case .themes:
            router.showThemeModule()
        case .help:
            if let url = URL(string: Constants.Links.feedbackURL) {
                router.openURL(url)
            }
        case .rate:
            if let url = URL(string: Constants.Links.appstoreURL) {
                router.openURL(url)
            }
        }
    }
    
    func getModel(for indexPath: IndexPath) -> SettingsCellModel? {
        guard let section = SettingsListSections(rawValue: indexPath.section),
            let data = cells[section] else {
            return nil
        }
        
        let model = data[indexPath.row]
        
        switch model {
        case .themes:
            return SettingsCellModel(icon: model.icon, title: model.title,
                                     info: themeManager.theme.rawValue.localized(),
                                     navigatable: model.navigable)
        case .help, .rate:
            return SettingsCellModel(icon: model.icon, title: model.title,
                                     info: nil, navigatable: model.navigable)
        }
    }
}

// MARK: SettingsInteractorOutput
extension SettingsPresenter: SettingsInteractorOutput {

}

// MARK: ThemeObserver
extension SettingsPresenter: ThemeObserver {
    func themeDidChange(_ theme: Theme) {
        view.update(theme: theme)
    }
}

// MARK: Locale
extension SettingsPresenter {
    private enum Locale {
        static let title: String = "Settings"
    }
}
