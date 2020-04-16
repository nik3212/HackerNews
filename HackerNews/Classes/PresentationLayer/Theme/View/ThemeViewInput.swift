//
//  ThemeViewInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 27/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol ThemeViewInput: class, Presentable, ThemeUpdatable {
    func setupInitialState(title: String)
    func reloadData()
}
