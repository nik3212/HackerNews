//
//  Themeable.swift
//  HackerNews
//
//  Created by Никита Васильев on 14.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

protocol ThemeObserver: class {
    func themeDidChange(_ theme: Theme)
}
