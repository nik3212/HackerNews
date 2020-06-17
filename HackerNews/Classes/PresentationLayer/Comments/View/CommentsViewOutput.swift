//
//  CommentsViewOutput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import struct HNService.PostModel

protocol CommentsViewOutput: class {
    func viewIsReady()
    func numberOfRows(in section: Int) -> Int
    func getPost() -> PostModel?
    func getModel(for indexPath: IndexPath) -> BaseCellViewModel
    func didSelectRow(at indexPath: IndexPath)
    func willDisplay(for indexPath: IndexPath)
    func heightForRow(at indexPath: IndexPath) -> CGFloat
    func numbersOfSection() -> Int
}
