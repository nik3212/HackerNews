//
//  PostViewerPresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 23/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit

class PostViewerPresenter {
    // MARK: Output
    weak var view: PostViewerViewInput!
    var interactor: PostViewerInteractorInput!
    var router: PostViewerRouterInput!
}

// MARK: PostViewerViewOutput
extension PostViewerPresenter: PostViewerViewOutput {
    func viewIsReady() {
        view.setupInitialState()
    }
}

// MARK: PostViewerInteractorOutput
extension PostViewerPresenter: PostViewerInteractorOutput {

}

// MARK: PostViewerModuleInput
extension PostViewerPresenter: PostViewerModuleInput {
    func show(url: URL) {
        
    }
    

}
