//
//  StoryType+AllValues.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.07.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import enum HNService.StoryType

extension StoryType {
    var displayName: String {
        return "\(self)".capitalizingFirstLetter()
    }
    
    static var allValues: [Self] {
        var value = 0
        var result: [Self] = []
        
        while let item = StoryType(rawValue: value) {
            result.append(item)
            value += 1
        }
        
        return result
    }
}
