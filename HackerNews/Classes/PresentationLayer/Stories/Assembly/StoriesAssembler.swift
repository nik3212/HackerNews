//
//  StoriesAssembler.swift
//  HackerNews
//
//  Created by Никита Васильев on 10.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

final class StoriesAssembler: TabBarViewProtocol {
    var icon: UIImage? {
        return nil
    }
    
    var title: String? {
        return nil
    }
    
    func configureViewController() -> UIViewController {
        guard let viewController = StoriesConfigurator().configure() else {
            fatalError("StoriesViewController shouldn't be nil")
        }
        
        return viewController
    }
}
