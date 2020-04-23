//
//  StoriesPresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

enum SkeletonState {
    case enabled
    case disabled
}

class StoriesPresenter {
    // MARK: Public Properties
    weak var view: StoriesViewInput!
    var interactor: StoriesInteractorInput!
    var router: StoriesRouterInput!
    var themeManager: ThemeManagerProtocol!
    
    // MARK: Private Properties
    private var storyType: StoryType = .new
    private var skeletonState: SkeletonState = .disabled
    private var ids: [Int] = []
    private var items: [NewsModel] = []
    private var models: [AlertActionModel] {
        return [AlertActionModel(title: "New", style: .default, action: { [weak self] in self?.storyType = .new }),
                AlertActionModel(title: "Top", style: .default, action: { [weak self] in self?.storyType = .top }),
                AlertActionModel(title: "Best", style: .default, action: { [weak self] in self?.storyType = .best }),
                AlertActionModel(title: "Cancel", style: .cancel, action: nil)]
    }
    
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
        return skeletonState == .enabled ? StoriesConstants.skeletonCount : items.count
    }
    
    func getModel(for row: Int) -> NewsModel {
        return items[row]
    }
    
    func viewIsReady() {
        view.setupInitialState(theme: themeManager.theme, leftNavigationButtonImage: .filter)
        changeNavigationTitle(with: storyType)
        interactor.loadStories()
        themeManager?.addObserver(self)
        skeletonState = .enabled
    }
    
    func didSelectRow(at row: Int) {
        
    }
    
    func prefetch(at indexPath: IndexPath) {
        guard !items.isEmpty, indexPath.row >= items.count - 1 else { return }
        interactor.loadNews(with: loadingIds)
    }
    
    func leftNivagtionBarButtonTapped() {
        router.openFilterModule(with: models)
    }
}

// MARK: StoriesInteractorOutput
extension StoriesPresenter: StoriesInteractorOutput {
    func loadTopStoriesSuccess(ids: [Int]) {
        self.ids = ids
        interactor.loadNews(with: loadingIds)
    }
    
    func loadTopStoriesFailed(error: Error) {
        
    }
    
    func loadItemsSuccess(_ items: [NewsModel]) {
        self.items.append(contentsOf: items.sorted(by: { $0.id > $1.id }))
        skeletonState = .disabled
        view.hideRefreshControl()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.reloadData()
        }
    }
    
    func loadItemsFailed(error: Error) {
        
    }
    
    func refreshStories() {
        ids.removeAll()
        items.removeAll()
        skeletonState = .enabled
        view.reloadData()
        interactor.loadStories()
    }
    
    func getSkeletonState() -> SkeletonState {
        return skeletonState
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
        static let skeletonCount: Int = 10
    }
}
