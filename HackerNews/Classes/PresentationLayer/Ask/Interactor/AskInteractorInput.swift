//
//  AskInteractorInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import protocol HNService.HNServiceProtocol

protocol AskInteractorInput {
    var output: AskInteractorOutput! { get set }
    var networkService: HNServiceProtocol? { get set }
    
    func fetchAskIds()
    func fetchPosts(with ids: [Int])
}
