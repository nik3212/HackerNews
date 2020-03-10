//
//  NibLoadableView.swift
//  HackerNews
//
//  Created by Никита Васильев on 24/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension UITableViewCell: NibLoadableView { }

extension NibLoadableView where Self: UIView {
    static var NibName: String {
        return String(describing: self)
    }
}
