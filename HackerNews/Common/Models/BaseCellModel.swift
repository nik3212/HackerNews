//
//  BaseCellModel.swift
//  HackerNews
//
//  Created by Никита Васильев on 26.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit.UIView

protocol BaseCellViewModel {
    static var cellClass: UIView.Type { get }
    
    func setup(_ cell: UIView)
}

protocol CellViewModel: BaseCellViewModel {
    associatedtype CellClass: UIView
    
    func setup(on cell: CellClass)
}

extension CellViewModel {
    static var cellClass: UIView.Type {
        return Self.CellClass.self
    }
    
    func setup(_ cell: UIView) {
        guard let cell = cell as? Self.CellClass else { return }
        setup(on: cell)
    }
}
