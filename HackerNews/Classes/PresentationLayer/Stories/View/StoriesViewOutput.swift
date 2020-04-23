//
//  StoriesViewOutput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation

protocol StoriesViewOutput: class {
    func viewIsReady()
    func prefetch(at indexPath: IndexPath)
    func didSelectRow(at row: Int)
    func numberOfRows() -> Int
    func refreshStories()
    func leftNivagtionBarButtonTapped()
    func getModel(for row: Int) -> NewsModel
    func getSkeletonState() -> SkeletonState
}
