//
//  ShowStoriesResource.swift
//  HackerNews
//
//  Created by Никита Васильев on 05.05.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

final public class ShowStoriesResource: BaseResource<[Int]> {
    override public var path: String {
        return Constants.Endpoints.showStories
    }
}
