//
//  TopStoriesResource.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import NetworkManager

class TopStoriesResource: BaseResource<Item> {
    override var path: String {
        return "topstories"
    }
}
