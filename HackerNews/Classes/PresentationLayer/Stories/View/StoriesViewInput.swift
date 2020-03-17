//
//  StoriesViewInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol StoriesViewInput: class, Presentable {
    func setupInitialState()
    func changeNavigationTitle(with title: String)
}
