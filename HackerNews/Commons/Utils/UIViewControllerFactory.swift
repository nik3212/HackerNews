//
//  UIViewControllerFactory.swift
//  HackerNews
//
//  Created by Никита Васильев on 24/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

extension UIStoryboard {
    // swiftlint:disable identifier_name
    enum Storyboard: String {
        case Main
        case TopStories
        case NewsStories
        case AskStories
        case ShowStories
        case Comments
        var fileName: String {
            return rawValue
        }
    }
    // swiftlint:enable identifier_name
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.fileName, bundle: bundle)
    }
    func instantiateViewController<T: UIViewController>() -> T {
        
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
    func instantiateViewController<T: UIViewController>(_ storyboardIdentifier: String) -> T {
        
        guard let viewController = self.instantiateViewController(withIdentifier: storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(storyboardIdentifier) ")
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
struct ViewControllerFactory {
    static func instantiate<T: UIViewController>(_ storyboard: UIStoryboard.Storyboard) -> T {
        return UIStoryboard(storyboard: storyboard).instantiateViewController()
    }
    static func instantiate<T: UIViewController>(_ storyboard: UIStoryboard.Storyboard, storyboardIdentifier: String) -> T {
        return UIStoryboard(storyboard: storyboard).instantiateViewController(storyboardIdentifier)
    }
}
