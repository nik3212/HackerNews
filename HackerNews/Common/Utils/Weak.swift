//
//  Weak.swift
//  HackerNews
//
//  Created by Никита Васильев on 16.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

class Weak<T> where T: AnyObject {
    private(set) weak var value: T?
    
    init(_ value: T?) {
        self.value = value
    }
}
