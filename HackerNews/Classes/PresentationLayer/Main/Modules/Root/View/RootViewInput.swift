//
//  RootViewInput.swift
//  HackerNews
//
//  Created by Никита Васильев on 17.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

protocol RootViewInput: class, ThemeUpdatable {
    func setupInitialState(theme: Theme)
}
