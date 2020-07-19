//
//  TopStoriesInterfaceController.swift
//  HackerNewsWatch WatchKit Extension
//
//  Created by Никита Васильев on 20.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import WatchKit
import HNService

final class TopStoriesInterfaceController: WKInterfaceController {
    
    // MARK: IBOutlets
    @IBOutlet private var loadingLabel: WKInterfaceLabel!
    @IBOutlet private var tableView: WKInterfaceTable!
    
    // MARK: Private Properties
    private let service = HNService()
    private var posts: [PostModel] = []
    
    // MARK: Life Cycle
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle(Locale.title.localized())
        loadingLabel.setText(Locale.loading.localized())
        fetchIds()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        self.pushController(withName: "CommentsInterfaceController", context: posts[rowIndex].kids)
    }
    
    // MARK: Private Methods
    private func fetchIds() {
        service.fetchIds(for: .top, completion: { [weak self] ids in
            self?.fetchPosts(with: ids)
        }, fail: { [weak self] error in
            self?.loadingLabel.setText(error.localizedDescription)
        })
    }
    
    private func fetchPosts(with ids: [Int]) {
        service.loadPosts(with: ids, completion: { [weak self] posts in
            self?.posts = posts
            self?.configureTableView(posts)
            self?.loadingLabel.setHidden(true)
        }) { [weak self] error in
            self?.loadingLabel.setText(error.localizedDescription)
        }
    }
    
    private func configureTableView(_ posts: [PostModel]) {
        tableView.setNumberOfRows(posts.count, withRowType: "PostCell")
        
        for (index, post) in posts.enumerated() {
            let controller = tableView.rowController(at: index) as! PostCell
            controller.setup(post: post)
        }
    }
}

// MARK: Locale
extension TopStoriesInterfaceController {
    private enum Locale {
        static let title: String = "Top Stories"
        static let loading: String = "Loading..."
    }
}
