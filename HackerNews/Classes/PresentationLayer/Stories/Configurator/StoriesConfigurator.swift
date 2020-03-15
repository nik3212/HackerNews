//
//  StoriesConfigurator.swift
//  HackerNews
//
//  Created by Никита Васильев on 10.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import Swinject

final class StoriesConfigurator: TabBarViewProtocol {
    var icon: UIImage? {
        return R.image.news()
    }
    
    var title: String? {
        return "News"
    }
    
    func configureViewController() -> UIViewController {
        guard let viewController = ApplicationAssembly.resolver.resolve(StoriesViewController.self) else {
            fatalError("StoriesViewController shouldn't be nil")
        }
        
        return UINavigationController(rootViewController: viewController)
    }
}
