//
//  Array+Range.swift
//  HackerNews
//
//  Created by Никита Васильев on 22.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe range: Range<Index>) -> ArraySlice<Element> {
        return self[Swift.min(range.startIndex, self.endIndex)..<Swift.min(range.endIndex, self.endIndex)]
    }
}
