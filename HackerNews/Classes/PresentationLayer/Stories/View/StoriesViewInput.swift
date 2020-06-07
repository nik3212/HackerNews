//
//  StoriesViewInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol StoriesViewInput: class, Presentable, ThemeUpdatable {
    var output: StoriesViewOutput! { get set }
    
    func setupInitialState(title: String, theme: Theme, titles: [String])
    func setUserInteractorEnabled(to state: Bool)
    func scrollContentToTop()
    func reloadData()
    func hideRefreshControl()
}
