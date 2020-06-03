//
//  WeakObject.swift
//  HackerNews
//
//  Created by Никита Васильев on 28.05.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

class WeakObject<T> where T: AnyObject {
    
    // MARK: Private Properties
    
    /// Identifier.
    private let identifier: ObjectIdentifier
    
    /// Wrapped object.
    fileprivate(set) weak var object: T?
    
    // MARK: Initialization
    
    /// Create a new `WeakObject` instance.
    ///
    /// - Parameter object: Wrapped object.
    init(object: T) {
        self.identifier = ObjectIdentifier(object)
        self.object = object
        
        print("Identifier: \(identifier)")
    }
}

// MARK: Equatable
extension WeakObject: Equatable {
    static func == (lhs: WeakObject<T>, rhs: WeakObject<T>) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

// MARK: Hashable
extension WeakObject: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
