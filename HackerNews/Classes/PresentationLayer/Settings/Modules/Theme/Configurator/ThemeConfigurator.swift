//
//  ThemeConfigurator.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 27/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Swinject

final class ThemeConfigurator {
    
    // MARK: Private Properties
    private var viewController: ThemeViewController?
    private let assembler: Assembler
    
    // MARK: Initialization
    init(parentAssembler: Assembler) {
        assembler = Assembler([ThemeModuleAssembly()], parent: parentAssembler)
    }
    
    // MARK: Public Methods
    func configure() -> ThemeModuleInput? {
        if let viewController = assembler.resolver.resolve(ThemeViewController.self) {
            self.viewController = viewController
            return assembler.resolver.resolve(ThemeModuleInput.self, argument: viewController)
        }
        
        return nil
    }
}
