//
//  CommentsConfigurator.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Swinject
import struct HNService.PostModel

final class CommentsConfigurator {
    // MARK: Private Properties
    private var viewController: CommentsViewController?
    private let assembler: Assembler
    
    // MARK: Initialization
    init(parentAssembler: Assembler) {
        assembler = Assembler([CommentsModuleAssembly()], parent: parentAssembler)
    }
    
    // MARK: Public Methods
    func configure(post: PostModel) -> CommentsViewController? {
        if let viewController = assembler.resolver.resolve(CommentsViewController.self, argument: post) {
            return viewController
        }
        return nil
    }
}
