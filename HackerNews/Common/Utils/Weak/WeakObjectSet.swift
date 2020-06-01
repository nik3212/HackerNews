//
//  WeakObjectSet.swift
//  HackerNews
//
//  Created by Никита Васильев on 28.05.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

final class WeakObjectSet<T> where T: AnyObject {
    
    // MARK: Private Properties
    
    /// Constains all objects.
    fileprivate(set) var objects: Set<WeakObject<T>>
    
    // MARK: Public Properties
    
    /// Return all valid object that contains in set.
    ///
    /// - Complexity: `O(n)`
    ///
    /// - Returns: An array of valid objects.
    var allObjects: [T] {
        return objects.compactMap { $0.object }
    }
    
    // MARK: Initialization
    
    /// Create a new `WeakObjectSet` instance with empty data.
    init() {
        self.objects = Set<WeakObject<T>>([])
    }
    
    /// Create a new `WeakObjectSet` instance with objects.
    ///
    /// - Parameter objects: An array that contains objects to be appended to set.
    init(objects: [T]) {
        self.objects = Set<WeakObject<T>>(objects.map({ WeakObject(object: $0) }))
    }
    
    // MARK: Public Methods
    
    /// Returns a Boolean value that indicates whether the given element exists in the set.
    ///
    /// - Parameter object: An element to look for in the set.
    ///
    /// - Complexity: O(1)
    ///
    /// - Returns: true if member exists in the set; otherwise, false.
    func contains(_ object: T) -> Bool {
        return objects.contains(WeakObject(object: object))
    }
    
    /// Add object to set.
    ///
    /// - Parameter object: The object to be added to set.
    func append(_ object: T) {
        guard !contains(object) else { return }
        objects.formUnion([WeakObject(object: object)])
    }
    
    /// Add objects to set.
    ///
    /// - Complexity:
    ///
    /// - Parameter array: The array to be added to set.
    func append(contentsOf array: [T]) {
        array.forEach { append($0) }
    }
    
    /// Remove object from set.
    ///
    /// - Complexity: O(n)
    ///
    /// - Parameter object: The object to be delete.
    func remove(_ object: T) {
        objects = objects.filter { $0.object !== object }
    }
}
