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
    var themeManager: ThemeManagerProtocol!
    
    // MARK: Private Properties
    private var themes: [(title: String, theme: Theme)] = []
}

// MARK: ThemeViewOutput
extension ThemePresenter: ThemeViewOutput {
    func didSelectRow(at indexPath: IndexPath) {
        themeManager.theme = themes[indexPath.row].theme
        router.dismiss()
    }
    
    func viewIsReady() {
        view.setupInitialState(title: ThemeConstants.title, theme: themeManager.theme)
        themeManager.addObserver(self)
        themes = themeManager.themes.map({ ($0.rawValue.localized(), $0) })
        view.reloadData()
    }
    
    func numberOfRows(in section: Int) -> Int {
        return themes.count
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func getModel(for indexPath: IndexPath) -> (title: String, isSelected: Bool) {
        let isSelected = themeManager.theme == themes[indexPath.row].theme
        return (title: themes[indexPath.row].title, isSelected: isSelected)
    }
    
    func titleForHeader(in section: Int) -> String {
        return ThemeConstants.appearanceTitle
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

// MARK: ThemeObserver
extension ThemePresenter: ThemeObserver {
    func themeDidChange(_ theme: Theme) {
        view.update(theme: theme)
    }
}

// MARK: Constants
extension ThemePresenter {
    private enum ThemeConstants {
        static let title: String = "Themes".localized()
        static let appearanceTitle: String = "Appearance".localized()
    }
}
