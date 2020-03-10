//
//  TabBarViewProtocol.swift
//  HackerNews
//
//  Created by Никита Васильев on 04.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

protocol TabBarViewProtocol {
    var icon: UIImage? { get }
    var title: String? { get }
    
    func configureViewController() -> UIViewController
}
