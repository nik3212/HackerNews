//
//  StoriesConfigurator.swift
//  HackerNews
//
//  Created by Никита Васильев on 10.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import Swinject

final class StoriesConfigurator {
    
    // MARK: Private Properties
    private let assembler: Assembler
    
    // MARK: Initialization
    init(parentAssembler: Assembler) {
        assembler = Assembler([StoriesModuleAssembly()], parent: parentAssembler)
    }
}

// MARK: TabBarViewProtocol
extension StoriesConfigurator: TabBarViewProtocol {
    var icon: UIImage? {
        return R.image.news()
    }
    
    var title: String? {
        return Locale.title.localized()
    }
    
    func configureViewController() -> UIViewController {
        guard let viewController = assembler.resolver.resolve(PostsViewController.self, name: "StoriesVC") else {
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

// MARK: Locale
extension StoriesConfigurator {
    private enum Locale {
        static let title: String = "Stories"
    }
}
