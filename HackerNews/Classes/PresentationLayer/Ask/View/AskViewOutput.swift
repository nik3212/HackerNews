//
//  AskViewOutput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation

protocol AskViewOutput: class {
    func viewIsReady()
    func getNumberOfRow() -> Int
    func prefetch(at indexPath: IndexPath)
    func getModel(for indexPath: IndexPath) -> BaseCellViewModel
    func didSelectRow(at row: Int)
    func refreshStories()
    func getEmptyDataSetTitle() -> String
    func getEmptyDataSetDecription() -> String
    func getEmptyDataSetImage() -> Image
}
