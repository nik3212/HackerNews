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
    
    // MARK: Private Properties
    private var storyType: StoryType = .new
    private var ids: [Int] = []
    private var items: [ItemModel] = []
    
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
    func viewIsReady() {
        changeNavigationTitle(with: storyType)
        interactor.loadStories()
    }
}

// MARK: StoriesInteractorOutput
extension StoriesPresenter: StoriesInteractorOutput {
    func loadTopStoriesSuccess(ids: [Int]) {
        self.ids = ids
        interactor.loadNews(with: ids)
    }
    
    func loadTopStoriesFailed(error: Error) {
        
    }
    
    func loadItemsSuccess(_ items: [ItemModel]) {
        
    }
    
    func loadItemsFailed(error: Error) {
        
    }
}

extension StoriesPresenter {
    enum StoryType: String {
        case new = "New"
        case top = "Top"
        case best = "Best"
    }
}
