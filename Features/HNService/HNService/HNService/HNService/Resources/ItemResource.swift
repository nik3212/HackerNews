//
//  ItemResource.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

final public class ItemResource: BaseResource<ItemModel> {
    
    // MARK: Public Properties
    
    /// A `Int` value that contains the item id.
    let id: Int
    
    // MARK: Override
    override public  var path: String {
        return "item/\(id).json"
    }
    
    // MARK: Initialization
    
    /// Create  a new `ItemResource` instance.
    ///
    /// - Parameter id: A `Int` value that contains the item id.
    init(id: Int) {
        self.id = id
    }
}
