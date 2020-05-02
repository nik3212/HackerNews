//
//  AskPresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

final class AskPresenter {
    // MARK: Public Properties
    weak var view: AskViewInput!
    var interactor: AskInteractorInput!
    var router: AskRouterInput!
    var themeManager: ThemeManagerProtocol!
    
    // MARK: Private Properties
    private var skeletonState: SkeletonState = .disabled
    private var ids: [Int] = []
    private var posts: [PostModel] = []
    private var errorDescription: String?
    
    private var loadingIds: [Int] {
        let count = self.posts.count
        return Array(ids[safe:count..<count + AskConstants.loadItemsCountPerOnce])
    }
    
    // MARK: Private Methods
    private func showError(_ error: Error) {
        skeletonState = .disabled
        errorDescription = error.localizedDescription
        view.reloadData()
    }
}

// MARK: AskViewOutput
extension AskPresenter: AskViewOutput {    
    func viewIsReady() {
        view.setupInitialState(title: AskConstants.title.localized(), theme: themeManager.theme)
        themeManager.addObserver(self)
        skeletonState = .enabled
        interactor.fetchAskIds()
    }
    
    func didSelectRow(at row: Int) {
        router.openCommentsModule(for: posts[row])
    }
    
    func prefetch(at indexPath: IndexPath) {
        guard !posts.isEmpty, indexPath.row >= posts.count - 1 else { return }
        interactor.fetchPosts(with: loadingIds)
    }
    
    func getModel(for indexPath: IndexPath) -> BaseCellViewModel {
        if skeletonState == .enabled {
            return SkeletonCellViewModel(theme: themeManager.theme)
        }
        return PostCellViewModel(post: posts[indexPath.row], theme: themeManager.theme)
    }
    
    func getNumberOfRow() -> Int {
        return skeletonState == .enabled ? AskConstants.skeletonCount : posts.count
    }
    
    func refreshStories() {
        view.setUserInteractorEnabled(to: false)
        skeletonState = .enabled
        ids.removeAll()
        posts.removeAll()
        view.reloadData()
        interactor.fetchAskIds()
    }
    
    func getEmptyDataSetTitle() -> String {
        return AskConstants.emptyTitle.localized()
    }
    
    func getEmptyDataSetDecription() -> String {
        return errorDescription ?? ""
    }
    
    func getEmptyDataSetImage() -> Image {
        return .connectionError
    }
}

// MARK: AskInteractorOutput
extension AskPresenter: AskInteractorOutput {
    func fetchAskSuccess(ids: [Int]) {
        self.ids = ids
        interactor.fetchPosts(with: loadingIds)
    }
    
    func fetchAskFailed(error: Error) {
        showError(error)
    }
    
    func fetchPostsSuccess(_ posts: [PostModel]) {
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
extension AskPresenter: ThemeObserver {
    func themeDidChange(_ theme: Theme) {
        view.update(theme: theme)
    }
}

// MARK: Constants
extension AskPresenter {
    private enum AskConstants {
        static let loadItemsCountPerOnce: Int = 20
        static let skeletonCount: Int = 10
        
        static let title: String = "Ask"
        static let emptyTitle: String = "No stories to show"
    }
}
