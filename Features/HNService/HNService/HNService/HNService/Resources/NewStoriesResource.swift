//
//  NewStoriesResource.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

final public class NewStoriesResource: BaseResource<[Int]> {
    override public var path: String {
        return Constants.Endpoints.newStories
    }
}
