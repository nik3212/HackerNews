//
//  StoriesPresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import enum HNService.StoryType
import struct HNService.PostModel

enum SkeletonState {
    case enabled
    case disabled
}

final class StoriesPresenter {
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
    private var isFinished: Bool = false
    
    private var skeletonCount: Int {
        return Int(UIScreen.main.bounds.height) / 84 + 1
    }
    
    private var loadingIds: [Int] {
        let count = self.stories.count
        return Array(ids[safe:count..<count + StoriesConstants.loadItemsCountPerOnce])
    }
    
    // MARK: Private Methods
    private func fetchStories(by type: StoryType) {
        self.storyType = type
        interactor.fetchIds(for: type)
    }
    
    private func backToInitialState() {
        isFinished = false
        interactor.cancleRequests()
        view.setUserInteractorEnabled(to: false)
        
        ids.removeAll()
        stories.removeAll()
        skeletonState = .enabled
        view.reloadData()
        view.scrollContentToTop()
    }
    
    private func showError(_ error: Error) {
        if error._code == StoriesConstants.canceledCode { return }
        
        view.setUserInteractorEnabled(to: true)
        skeletonState = .disabled
        errorDescription = error.localizedDescription
        view.hideRefreshControl()
        view.reloadData()
        view.setLoadingIndicator(to: false)
    }
}

// MARK: StoriesViewOutput
extension StoriesPresenter: StoriesViewOutput {    
    func numberOfRows() -> Int {
        return skeletonState == .enabled ? skeletonCount : stories.count
    }
    
    func getModel(for indexPath: IndexPath) -> BaseCellViewModel {
        if skeletonState == .enabled {
            return SkeletonCellViewModel(theme: themeManager.theme)
        }
        return PostCellViewModel(post: stories[indexPath.row],
                                 theme: themeManager.theme,
                                 placeholderImage: .placeholder)
    }
    
    func viewIsReady() {
        skeletonState = .enabled
        view.setupInitialState(title: StoriesConstants.title.localized(),
                               theme: themeManager.theme,
                               titles: StoryType.allValues.map { $0.displayName })
        view.setUserInteractorEnabled(to: false)
        themeManager?.addObserver(self)
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
        view.setLoadingIndicator(to: !isFinished)
        guard !isFinished, !stories.isEmpty, indexPath.row >= stories.count - 1 else { return }
        interactor.fetchPosts(with: loadingIds)
    }
}

// MARK: StoriesInteractorOutput
extension StoriesPresenter: StoriesInteractorOutput {
    func fetchIdsSuccess(_ ids: [Int]) {
        self.ids = ids
        interactor.fetchPosts(with: loadingIds)
    }
    
    func fetchIdsFail(error: Error) {
        showError(error)
    }
        
    func fetchItemsSuccess(_ items: [PostModel]) {
        self.isFinished = items.isEmpty
        self.stories.append(contentsOf: items.sorted(by: { $0.id > $1.id }))
        view.setUserInteractorEnabled(to: true)
        skeletonState = .disabled
        view.reloadData()
        view.hideRefreshControl()
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
        guard let type = StoryType(rawValue: index) else { return }
        
        backToInitialState()
        fetchStories(by: type)
    }
    
    func getEmptyDataSetTitle() -> String {
        return StoriesConstants.emptyTitle.localized()
    }
    
    func getEmptyDataSetDecription() -> String {
        return errorDescription ?? ""
    }
    
    func getEmptyDataSetImage() -> Image {
        return .connectionError
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

        static let canceledCode: Int = -999
        
        static let title: String = "Stories"
        static let emptyTitle: String = "No stories to show"
    }
}
