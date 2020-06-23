//
//  PostsViewInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol PostsViewInput: class, Presentable, ThemeUpdatable {
    var output: PostsViewOutput! { get set }
    
    func setupInitialState(title: String, theme: Theme, titles: [String]?)
    func setUserInteractorEnabled(to state: Bool)
    func scrollContentToTop()
    func reloadData()
    func hideRefreshControl()
    func setLoadingIndicator(to state: Bool)
}
