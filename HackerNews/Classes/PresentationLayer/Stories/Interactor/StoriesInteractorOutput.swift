//
//  StoriesInteractorOutput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import struct HNService.PostModel

protocol StoriesInteractorOutput: class {
    func fetchIdsSuccess(_ ids: [Int])
    func fetchIdsFail(error: Error)
    
    func fetchItemsSuccess(_ items: [PostModel])
    func fetchItemsFailed(error: Error)
}
