//
//  UIViewControllerFactory.swift
//  HackerNews
//
//  Created by Никита Васильев on 24/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(type: T.Type) -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier)")
        }
        
        return viewController
    }
    
    func instantiateViewController<T: UIViewController>(_ storyboardIdentifier: String) -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(storyboardIdentifier)")
        }

        return viewController
    }
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardIdentifiable { }
