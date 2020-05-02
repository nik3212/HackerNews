//
//  SkeletonCellViewModel.swift
//  HackerNews
//
//  Created by Никита Васильев on 03.05.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

struct SkeletonCellViewModel {
    let theme: Theme
}

// MARK: CellViewModel
extension SkeletonCellViewModel: CellViewModel {
    func setup(on cell: SkeletonCell) {
        cell.apply(theme: theme)
    }
}
