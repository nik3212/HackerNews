//
//  StoriesViewInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol StoriesViewInput: class, Presentable, ThemeUpdatable {
    func setupInitialState(theme: Theme)
    func changeNavigationTitle(with title: String)
    func reloadData()
    func showAnimatedSkeleton()
    func hideAnimatedSkeleton()
    func hideRefreshControl()
}
