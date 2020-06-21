//
//  ShowConfigurator.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import Swinject

final class ShowConfigurator {
    
    // MARK: Private Properties
    private let assembler: Assembler
    
    // MARK: Initialization
    init(parentAssembler: Assembler) {
        assembler = Assembler([ShowModuleAssembly()], parent: parentAssembler)
    }
}

// MARK: TabBarViewProtocol
extension ShowConfigurator: TabBarViewProtocol {
    var icon: UIImage? {
        return R.image.show()
    }
    
    var title: String? {
        return "Show"
    }
    
    func configureViewController() -> UIViewController {
        guard let viewController = assembler.resolver.resolve(PostsViewController.self) else {
            fatalError("PostsViewController shouldn't be nil")
        }
        
        let item = UITabBarItem()
        item.image = icon
        item.title = title
        
        viewController.tabBarItem = item
        viewController.title = item.title
        
        return UINavigationController(rootViewController: viewController)
    }
}
