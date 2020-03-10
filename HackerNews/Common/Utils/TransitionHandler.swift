//
//  TransitionHandler.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

protocol TransitionHandler: class {
    func openModule(_ completion: @escaping (UIViewController) -> Void)
}

extension TransitionHandler where Self: UIViewController {
    func openModule(_ completion: @escaping (UIViewController) -> Void) {
        completion(self)
    }
}

extension UIViewController: TransitionHandler { }
