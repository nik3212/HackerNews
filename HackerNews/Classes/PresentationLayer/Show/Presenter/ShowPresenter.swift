//
//  ShowPresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import struct HNService.PostModel

final class ShowPresenter {
    // MARK: Public Properties
    weak var view: PostsViewInput!
    var interactor: ShowInteractorInput!
    var router: ShowRouterInput!
    var themeManager: ThemeManagerProtocol!
    
    // MARK: Private Properties
    private var skeletonState: SkeletonState = .disabled
    private var ids: [Int] = []
    private var posts: [PostModel] = []
    private var errorDescription: String?
    private var isFinished: Bool = false
    
    private var loadingIds: [Int] {
        let count = self.posts.count
        return Array(ids[safe:count..<count + ShowConstants.loadItemsCountPerOnce])
    }
    
    // MARK: Private Methods
    private func showError(_ error: Error) {
        skeletonState = .disabled
        errorDescription = error.localizedDescription
        view.setUserInteractorEnabled(to: true)
        view.reloadData()
    }
}

// MARK: ShowViewOutput
extension ShowPresenter: PostsViewOutput {
    func didSelectImage(at row: Int) {
    
    }
    
    func numberOfRows() -> Int {
        return skeletonState == .enabled ? ShowConstants.skeletonCount : posts.count
    }
    
    func getSkeletonState() -> SkeletonState {
        return skeletonState
    }
        
    func viewIsReady() {
        view.setupInitialState(title: ShowConstants.title.localized(), theme: themeManager.theme, titles: nil)
        view.setUserInteractorEnabled(to: false)
        view.update(theme: themeManager.theme)
        themeManager.addObserver(self)
        skeletonState = .enabled
        interactor.fetchShowIds()
    }
    
    func didSelectRow(at row: Int) {
        router.openCommentsModule(for: posts[row])
    }
    
    func prefetch(at indexPath: IndexPath) {
        view.setLoadingIndicator(to: !isFinished)
        guard !isFinished, !posts.isEmpty, indexPath.row >= posts.count - 1 else { return }
        interactor.fetchPosts(with: loadingIds)
    }
    
    func getModel(for indexPath: IndexPath) -> BaseCellViewModel {
        if skeletonState == .enabled {
            return SkeletonCellViewModel(theme: themeManager.theme)
        }
        return PostCellViewModel(post: posts[indexPath.row], theme: themeManager.theme, placeholderImage: .placeholder)
    }
    
    func refreshStories() {
        isFinished = false
        view.setUserInteractorEnabled(to: false)
        skeletonState = .enabled
        ids.removeAll()
        posts.removeAll()
        view.reloadData()
        interactor.fetchShowIds()
    }
    
    func getEmptyDataSetTitle() -> String {
        return ShowConstants.emptyTitle.localized()
    }
    
    func getEmptyDataSetDecription() -> String {
        return errorDescription ?? ""
    }
    
    func getEmptyDataSetImage() -> Image {
        return .connectionError
    }
}

// MARK: ShowInteractorOutput
extension ShowPresenter: ShowInteractorOutput {
    func fetchShowStoriesSuccess(ids: [Int]) {
        self.ids = ids
        interactor.fetchPosts(with: loadingIds)
    }
    
    func fetchShowStoriesFailed(error: Error) {
        showError(error)
    }
    
    func fetchPostsSuccess(_ posts: [PostModel]) {
        self.isFinished = posts.isEmpty
        self.posts.append(contentsOf: posts.sorted(by: { $0.id > $1.id }))
        view.setUserInteractorEnabled(to: true)
        skeletonState = .disabled
        view.reloadData()
        view.hideRefreshControl()
    }
    
    func fetchPostsFailed(error: Error) {
        showError(error)
    }
}

// MARK: ThemeObserver
extension ShowPresenter: ThemeObserver {
    func themeDidChange(_ theme: Theme) {
        view.update(theme: theme)
    }
}

// MARK: Constants
extension ShowPresenter {
    private enum ShowConstants {
        static let loadItemsCountPerOnce: Int = 20
        static let skeletonCount: Int = 10
        
        static let title: String = "Show"
        static let emptyTitle: String = "No stories to show"
    }
}
