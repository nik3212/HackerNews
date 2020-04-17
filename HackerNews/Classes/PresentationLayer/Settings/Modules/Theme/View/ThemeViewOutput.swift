//
//  ThemeViewOutput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 27/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation

protocol ThemeViewOutput: class {
    func viewIsReady()
    func didSelectRow(at indexPath: IndexPath)
    func numberOfRows(in section: Int) -> Int
    func numberOfSections() -> Int
    func getModel(for indexPath: IndexPath) -> (title: String, isSelected: Bool)
    func titleForHeader(in section: Int) -> String
}
