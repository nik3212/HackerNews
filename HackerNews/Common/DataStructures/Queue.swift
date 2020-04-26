//
//  Queue.swift
//  HackerNews
//
//  Created by Никита Васильев on 26.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

struct Queue<T> {
    
    // MARK: Private Properties
    private var queue: [T?] = []
    private var head = 0
    
    // MARK: Public Properties
    var isEmpty: Bool {
        // swiftlint:disable empty_count
        return count == 0
        // swiftlint:enable empty_count
    }
    
    var count: Int {
        return queue.count - head
    }
    
    var front: T? {
        if isEmpty { return nil }
        return queue[head]
    }
    
    // MARK: Initialization
    init() { }
    
    // MARK: Public Methods
    mutating func enqueue(_ item: T) {
        queue.append(item)
    }
    
    mutating func enqueue(_ items: [T]) {
        queue.append(contentsOf: items)
    }
    
    mutating func dequeue() -> T? {
        if isEmpty { return nil }
        
        guard head < queue.count, let item = queue[head] else { return nil }
        
        queue[head] = nil
        head += 1
        
        let percentage = Double(head) / Double(queue.count)
        
        if queue.count > 50 && percentage > 0.5 {
            queue.removeFirst(head)
            head = 0
        }
        
        return item
    }
    
    mutating func removeAll() {
        queue.removeAll()
        head = 0
    }
}
