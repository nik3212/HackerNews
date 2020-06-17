//
//  CommentsInteractorInput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import protocol HNService.HNServiceProtocol

protocol CommentsInteractorInput {
    var output: CommentsInteractorOutput! { get set }
    var networkService: HNServiceProtocol? { get set }
    
    func fetchComments(for id: Int)
}
