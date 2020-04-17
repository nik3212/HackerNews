//
//  SettingsViewOutput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation

protocol SettingsViewOutput: class {
    func viewIsReady()
    func getNumberOfRows(in section: Int) -> Int
    func getNumberOfSections() -> Int
    func getTitleForHeader(in section: Int) -> String?
    func didSelectRow(at indexPath: IndexPath)
    func getModel(for indexPath: IndexPath) -> SettingsCellModel?
}
