//
//  Weak.swift
//  HackerNews
//
//  Created by Никита Васильев on 16.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

struct Weak<T: AnyObject> {
    weak var value: T?
    
    init(_ value: T) {
        self.value = value
    }
}
