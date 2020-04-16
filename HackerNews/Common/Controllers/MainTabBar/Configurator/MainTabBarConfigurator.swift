//
//  MainTabBarConfigurator.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import Swinject

final class MainTabBarConfigurator {
    
    // MARK: Private Properties
    let assembler: Assembler
    
    // MARK: Initialization
    init(parentAssembler: Assembler) {
        assembler = Assembler([MainTabBarModuleAssembly()], parent: parentAssembler)
    }
    
    // MARK: Public Methods
    func configure() -> MainTabBarViewController {
        guard let viewController = assembler.resolver.resolve(MainTabBarViewController.self) else {
            fatalError("Cann't resolve MainTabBarViewController")
        }
        return viewController
    }
}
