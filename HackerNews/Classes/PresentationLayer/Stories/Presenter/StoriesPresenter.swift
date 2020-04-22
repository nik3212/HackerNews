//
//  StoriesPresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class StoriesPresenter {
    // MARK: Public Properties
    weak var view: StoriesViewInput!
    var interactor: StoriesInteractorInput!
    var router: StoriesRouterInput!
    var themeManager: ThemeManagerProtocol!
    
    // MARK: Private Properties
    private var storyType: StoryType = .new
    private var ids: [Int] = []
    private var items: [NewsModel] = []
    
    private var loadingIds: [Int] {
        let count = self.items.count
        return Array(ids[safe:count..<count + StoriesConstants.loadItemsCountPerOnce])
    }
    
    // MARK: Private Methods
    private func changeNavigationTitle(with storyType: StoryType) {
        switch storyType {
        case .new:
            view.changeNavigationTitle(with: StoryType.new.rawValue.localized())
        case .best:
            view.changeNavigationTitle(with: StoryType.best.rawValue.localized())
        case .top:
            view.changeNavigationTitle(with: StoryType.top.rawValue.localized())
        }
    }
}

// MARK: StoriesViewOutput
extension StoriesPresenter: StoriesViewOutput {
    func numberOfRows() -> Int {
        return items.count
    }
    
    func getModel(for row: Int) -> NewsModel {
        return items[row]
    }
    
    func viewIsReady() {
        view.setupInitialState(theme: themeManager.theme)
        view.showAnimatedSkeleton()
        changeNavigationTitle(with: storyType)
        interactor.loadStories()
        themeManager?.addObserver(self)
    }
    
    func didSelectRow(at row: Int) {
        
    }
    
    func prefetch(at indexPath: IndexPath) {
        guard !items.isEmpty, indexPath.row >= items.count - 1 else { return }
        interactor.loadNews(with: loadingIds)
    }
}

// MARK: StoriesInteractorOutput
extension StoriesPresenter: StoriesInteractorOutput {
    func loadTopStoriesSuccess(ids: [Int]) {
        self.ids = ids.sorted(by: { $0 > $1 })
        interactor.loadNews(with: loadingIds)
    }
    
    func loadTopStoriesFailed(error: Error) {
        
    }
    
    func loadItemsSuccess(_ items: [NewsModel]) {
        self.items.append(contentsOf: items)
        view.hideAnimatedSkeleton()
        view.reloadData()
        view.hideRefreshControl()
    }
    
    func loadItemsFailed(error: Error) {
        
    }
    
    func refreshStories() {
        ids.removeAll()
        items.removeAll()
        view.reloadData()
        view.showAnimatedSkeleton()
        interactor.loadStories()
    }
}

// MARK: StoryType
extension StoriesPresenter {
    enum StoryType: String {
        case new = "New"
        case top = "Top"
        case best = "Best"
    }
}

// MARK: ThemeObserver
extension StoriesPresenter: ThemeObserver {
    func themeDidChange(_ theme: Theme) {
        view.update(theme: theme)
    }
}

// MARK: Constants
extension StoriesPresenter {
    private enum StoriesConstants {
        static let loadItemsCountPerOnce: Int = 20
    }
}
