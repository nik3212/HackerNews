//
//  CommentsViewInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Foundation

protocol CommentsViewInput: class, Presentable, ThemeUpdatable {
    var output: CommentsViewOutput! { get set }
    
    func setupInitialState(title: String)
    func displayMessage(text: String)
    func reloadData()
    func showActivityIndicator()
    func hideActivityIndicator()
    func insertRows(at indexPaths: [IndexPath])
    func setLoadingIndicator(to state: Bool)
}
