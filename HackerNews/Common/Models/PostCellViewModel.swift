//
//  PostCellViewModel.swift
//  HackerNews
//
//  Created by Никита Васильев on 26.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import struct HNService.PostModel

struct PostCellViewModel {
    let post: PostModel
    let theme: Theme
    let placeholderImage: Image
}

// MARK: BaseCellViewModel
extension PostCellViewModel: CellViewModel {
    func setup(on cell: StoryTableViewCell) {
        cell.apply(theme: theme)
        cell.setup(model: post, placeholder: placeholderImage)
    }
}
