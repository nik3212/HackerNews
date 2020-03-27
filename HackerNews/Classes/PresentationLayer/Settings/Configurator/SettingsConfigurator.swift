//
//  SettingsConfigurator.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Swinject

final class SettingsConfigurator {

    // MARK: Public Properties
    let assembler: Assembler
    
    // MARK: Initialization
    init(parentAssembler: Assembler) {
        assembler = Assembler([SettingsModuleAssembly()], parent: parentAssembler)
    }
}

// MARK: TabBarViewProtocol
extension SettingsConfigurator: TabBarViewProtocol {
    var icon: UIImage? {
        return R.image.settings()
    }
    
    var title: String? {
        return "Settings"
    }
    
    func configureViewController() -> UIViewController {
        guard let viewController = assembler.resolver.resolve(SettingsViewController.self) else {
            fatalError("StoriesViewController shouldn't be nil")
        }
        
        return UINavigationController(rootViewController: viewController)
    }
}
