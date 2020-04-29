//
//  StoriesViewInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol StoriesViewInput: class, Presentable, ThemeUpdatable {
    func setupInitialState(theme: Theme, titles: [String])
    func changeNavigationTitle(with title: String)
    func setUserInteractorEnabled(to state: Bool)
    func scrollContentToTop()
    func reloadData()
    func hideRefreshControl()
}
