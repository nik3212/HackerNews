//
//  AskConfigurator.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import Swinject

final class AskConfigurator {
    
    // MARK: Private Properties
    private let assembler: Assembler
    
    // MARK: Initialization
    init(parentAssembler: Assembler) {
        assembler = Assembler([AskModuleAssembly()], parent: parentAssembler)
    }
}

// MARK: TabBarViewProtocol
extension AskConfigurator: TabBarViewProtocol {
    var icon: UIImage? {
        return R.image.ask()
    }
    
    var title: String? {
        return "Ask".localized()
    }
    
    func configureViewController() -> UIViewController {
        guard let viewController = assembler.resolver.resolve(PostsViewController.self, name: "AskView") else {
            fatalError("AskViewController shouldn't be nil")
        }
        
        let item = UITabBarItem()
        item.image = icon
        item.title = title
        
        viewController.tabBarItem = item
        viewController.title = item.title
        
        return UINavigationController(rootViewController: viewController)
    }
}
