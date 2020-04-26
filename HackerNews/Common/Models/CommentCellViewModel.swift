//
//  CommentCellViewModel.swift
//  HackerNews
//
//  Created by Никита Васильев on 26.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

struct CommentCellViewModel {
    let comment: CommentModel
    let text: String
    let theme: Theme
}

// MARK: CellViewModel
extension CommentCellViewModel: CellViewModel {
    func setup(on cell: CommentCell) {
        cell.apply(theme: theme)
        cell.setup(model: comment, text: text)
    }
}
