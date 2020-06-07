//
//  AskViewInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol AskViewInput: class, Presentable, ThemeUpdatable {
    var output: AskViewOutput! { get set }
    
    func setupInitialState(title: String, theme: Theme)
    func setUserInteractorEnabled(to state: Bool)
    func reloadData()
    func hideRefreshControl()
}
