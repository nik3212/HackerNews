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
    private var stories: [PostModel] = []
    private var errorDescription: String?
    
    private var loadingIds: [Int] {
        let count = self.stories.count
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
    
    private func fetchStories(by type: StoryType) {
        self.storyType = type
        
        switch type {
        case .top:
            interactor.fetchTopStories()
        case .best:
            interactor.fetchBestStories()
        case .new:
            interactor.fetchNewStories()
        }
    }
    
    private func backToInitialState() {
        view.setUserInteractorEnabled(to: false)
        view.scrollContentToTop()
        ids.removeAll()
        stories.removeAll()
        skeletonState = .enabled
        //view.reloadData()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            self.view.reloadData()
//        }
        
        //view.reloadData()
    }
    
    private func showError(_ error: Error) {
        skeletonState = .disabled
        errorDescription = error.localizedDescription
        view.reloadData()
    }
}

// MARK: StoriesViewOutput
extension StoriesPresenter: StoriesViewOutput {
    func numberOfRows() -> Int {
        return skeletonState == .enabled ? StoriesConstants.skeletonCount : stories.count
    }
    
    func getModel(for row: Int) -> PostModel {
        return stories[row]
    }
    
    func viewIsReady() {
        view.setupInitialState(theme: themeManager.theme,
                               titles: StoryType.allCases.map { $0.rawValue.localized() })
        view.setUserInteractorEnabled(to: false)
        changeNavigationTitle(with: storyType)
        themeManager?.addObserver(self)
        skeletonState = .enabled
        fetchStories(by: storyType)
    }
    
    func didSelectRow(at row: Int) {
        router.openCommentsModule(for: stories[row])
    }
    
    func didSelectImage(at row: Int) {
        guard let url = stories[row].url else { return }
        router.openStories(from: url)
    }
    
    func prefetch(at indexPath: IndexPath) {
        guard !stories.isEmpty, indexPath.row >= stories.count - 1 else { return }
        interactor.fetchPosts(with: loadingIds)
    }
}

// MARK: StoriesInteractorOutput
extension StoriesPresenter: StoriesInteractorOutput {
    func fetchBestStoriesSuccess(ids: [Int]) {
        self.ids = ids
        interactor.fetchPosts(with: loadingIds)
    }
    
    func fetchBestStoriesFailed(error: Error) {
        showError(error)
    }
    
    func fetchNewStoriesSuccess(ids: [Int]) {
        self.ids = ids
        interactor.fetchPosts(with: loadingIds)
    }
    
    func fetchNewStoriesFailed(error: Error) {
        showError(error)
    }
    
    func fetchTopStoriesSuccess(ids: [Int]) {
        self.ids = ids
        interactor.fetchPosts(with: loadingIds)
    }
    
    func fetchTopStoriesFailed(error: Error) {
        showError(error)
    }
    
    func fetchItemsSuccess(_ items: [PostModel]) {
        self.stories.append(contentsOf: items.sorted(by: { $0.id > $1.id }))
        view.setUserInteractorEnabled(to: true)
        skeletonState = .disabled
        view.hideRefreshControl()
        //view.reloadData()
    }
    
    func fetchItemsFailed(error: Error) {
        showError(error)
    }
    
    func refreshStories() {
        backToInitialState()
        fetchStories(by: storyType)
    }
    
    func getSkeletonState() -> SkeletonState {
        return skeletonState
    }
    
    func segmentedControlDidChange(to index: Int) {
        let type = StoryType.allCases[index]
        backToInitialState()
        fetchStories(by: type)
        changeNavigationTitle(with: type)
    }
    
    func getEmptyDataSetTitle() -> String {
        return "No news to show"
    }
    
    func getEmptyDataSetDecription() -> String {
        return errorDescription ?? ""
    }
    
    func getEmptyDataSetImage() -> Image {
        return .connectionError
    }
}

// MARK: StoryType
extension StoriesPresenter {
    enum StoryType: String, CaseIterable {
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
