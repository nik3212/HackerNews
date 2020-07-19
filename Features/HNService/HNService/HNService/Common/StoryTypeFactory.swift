//
//  StoryTypeFactory.swift
//  HNService
//
//  Created by Никита Васильев on 19.07.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

public enum StoryType: Int {
    case new
    case best
    case top
    case ask
    case show
}

enum StoryTypeFactory {
    static func resource(for type: StoryType) -> BaseResource<[Int]> {
        switch type {
        case .new:
            return NewStoriesResource()
        case .best:
            return BestStoriesResource()
        case .top:
            return TopStoriesResource()
        case .ask:
            return AskStoriesResource()
        case .show:
            return ShowStoriesResource()
        }
    }
}
