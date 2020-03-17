//
//  NewsListDataSource.swift
//  HackerNews
//
//  Created by Никита Васильев on 04/11/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit
import NetworkManager

protocol StoriesListDelegate: class {
    func openCommentView(cell: NewsTableViewCell, storyId: Int)
}

class StoriesListDataSource: NSObject, UITableViewDataSource {
    
    weak var delegate: StoriesListDelegate?
    
    var ids = [Int]()
    var stories = [Item]()
    
    var fetchingMore = false
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: NewsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.story = stories[indexPath.row]
            cell.delegate = self
            return cell
        } else {
            let cell: LoadingTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.startAnimating()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return stories.count
        } else if section == 1 && fetchingMore && stories.count != ids.count {
            return 1
        }
        return 0
    }
}

extension StoriesListDataSource: NewsCellDelegate {
    func newsCellDidSelectComment(cell: NewsTableViewCell, storyId: Int) {
        delegate?.openCommentView(cell: cell, storyId: storyId)
    }
}
