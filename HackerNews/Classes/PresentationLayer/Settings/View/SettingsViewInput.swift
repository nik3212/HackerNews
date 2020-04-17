//
//  SettingsViewInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol SettingsViewInput: class, Presentable, ThemeUpdatable {
    func setupInitialState(title: String, theme: Theme)
}
