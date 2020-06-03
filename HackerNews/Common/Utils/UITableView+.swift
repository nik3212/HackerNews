//
//  UITableView+.swift
//  HackerNews
//
//  Created by Никита Васильев on 24/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit
extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier,
                                                  for: indexPath) as? T else {
                                                    fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableCell(forIndexPath indexPath: IndexPath, with model: BaseCellViewModel) -> UITableViewCell {
        let cellIdentifier = String(describing: type(of: model).cellClass)
        let cell = dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        model.setup(cell)
        
        return cell
    }
    
    func viewForHeader<T: UIView>(_: T.Type) -> T where T: NibLoadableView {
        guard let header = Bundle.main.loadNibNamed(T.NibName,
                                                    owner: self,
                                                    options: nil)?.first as? T else {
                                                        fatalError("Could not loadNibNamed: \(T.NibName)")
        }
        return header
    }
    
    func register<T: UITableViewCell>(_: T.Type) {
        let nib = UINib(nibName: T.NibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
