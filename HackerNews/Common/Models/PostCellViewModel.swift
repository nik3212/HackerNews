//
//  PostCellViewModel.swift
//  HackerNews
//
//  Created by Никита Васильев on 26.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

struct PostCellViewModel {
    let post: PostModel
    let theme: Theme
}

// MARK: BaseCellViewModel
extension PostCellViewModel: CellViewModel {
    func setup(on cell: StoryTableViewCell) {
        cell.setup(model: post)
        cell.apply(theme: theme)
    }
}
