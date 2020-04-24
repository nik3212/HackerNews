//
//  PostViewerConfigurator.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 23/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Swinject

final class PostViewerConfigurator {
    
    // MARK: Private Properties
    private let assembler: Assembler
    
    // MARK: Initialization
    init(parentAssembler: Assembler) {
        assembler = Assembler([PostViewerModuleAssembly()], parent: parentAssembler)
    }
    
    // MARK: Public Methods
    func configure() -> PostViewerViewController {
        guard let viewController = assembler.resolver.resolve(PostViewerViewController.self) else {
            fatalError("StoriesViewController shouldn't be nil")
        }
        return viewController
    }
    
    func open(url: URL) {

    }
}
