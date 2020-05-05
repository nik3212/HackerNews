//
//  UIView+.swift
//  HackerNews
//
//  Created by Никита Васильев on 05.05.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

extension UIView {
    func setView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
