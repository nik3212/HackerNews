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
    private var storyType: StoryType = .news
    
    // MARK: Private Methods
    private func changeNavigationTitle(with storyType: StoryType) {
        switch storyType {
        case .news:
            view.changeNavigationTitle(with: "News")
        case .best:
            view.changeNavigationTitle(with: "Best")
        case .top:
            view.changeNavigationTitle(with: "Top")
        }
    }
}

// MARK: StoriesViewOutput
extension StoriesPresenter: StoriesViewOutput {
    func viewIsReady() {
        changeNavigationTitle(with: storyType)
    }
}

// MARK: StoriesInteractorOutput
extension StoriesPresenter: StoriesInteractorOutput {
    enum StoryType {
        case news
        case top
        case best
    }
}
