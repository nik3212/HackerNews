//
//  StoriesPresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class StoriesPresenter {
    weak var view: StoriesViewInput!
    var interactor: StoriesInteractorInput!
    var router: StoriesRouterInput!
}

// MARK: StoriesViewOutput
extension StoriesPresenter: StoriesViewOutput {
    func viewIsReady() {
        view.setupInitialState()
    }
}

// MARK: StoriesInteractorOutput
extension StoriesPresenter: StoriesInteractorOutput {

}
