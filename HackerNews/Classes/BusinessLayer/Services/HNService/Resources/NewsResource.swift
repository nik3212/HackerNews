//
//  NewsResource.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

final class NewsResource: BaseResource<PostModel> {
    // MARK: Public Properties
    
    /// A `Int` value that contains the item id.
    let id: Int
    
    // MARK: Override
    override var path: String {
        return "item/\(id).json"
    }
    
    // MARK: Initialization
    
    /// Create  a new `NewsResource` instance.
    ///
    /// - Parameter id: A `Int` value that contains the item id.
    init(id: Int) {
        self.id = id
    }
}
