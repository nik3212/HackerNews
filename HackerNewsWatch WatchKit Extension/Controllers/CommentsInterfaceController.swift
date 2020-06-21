//
//  CommentsInterfaceController.swift
//  HackerNewsWatch WatchKit Extension
//
//  Created by Никита Васильев on 21.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import WatchKit
import HNService

final class CommentsInterfaceController: WKInterfaceController {
    
    // MARK: IBOutlets
    @IBOutlet private var loadingLabel: WKInterfaceLabel!
    @IBOutlet private var tableView: WKInterfaceTable!
    
    // MARK: Private Properties
    private let service = HNService()
    private var ids: [Int] = []
    private var comments: [CommentModel] = []
    private var commentTexts = [String]()
    private var loadingCommentId: Int?
    
    // MARK: Life Cycle
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle(Locale.title.localized())
        ids = context as! [Int]
        tableView.setHidden(true)
        if ids.isEmpty {
            loadingLabel.setText(Locale.noComments.localized())
        } else {
            fetchComments()
            loadingLabel.setText(Locale.loading.localized())
        }
        
    }
    
    // MARK: Private Methods
    private func fetchComments() {
        guard let id = ids.last, loadingCommentId == nil else {
            loadingLabel.setHidden(true)
            tableView.setHidden(false)
            return
        }
        ids.removeLast()
        self.loadingCommentId = id
        self.fetchComment(for: id)
    }
    
    private func prepareComments(from comment: CommentModel) {
        if comment.deleted {
            loadingCommentId = nil
            fetchComments()
            return
        }
    
        var commentObject = comment
        commentObject.level = 0
        
        var sortedComments = [comment]
        
        self.getComments(from: (commentObject.comments, 1), to: &sortedComments)

        var row = self.comments.count
        
        sortedComments.forEach { model in
            if model.deleted {
                return
            }
            
            if let text = model.text {
                self.commentTexts.append(text.htmlDecoded)
            }
            
            self.comments.append(model)
            
            row += 1
        }
        
        self.loadingCommentId = nil

        self.tableView.setNumberOfRows(comments.count, withRowType: "CommentCell")
        
        for (index, comment) in comments.enumerated() {
            let controller = tableView.rowController(at: index) as! CommentCell
            controller.setup(username: comment.by, text: commentTexts[index])
        }
        
        fetchComments()
    }
    
    private func getComments(from tuple: (graph: [CommentModel], level: Int), to comments: inout [CommentModel]) {
        for var comment in tuple.graph {
            comment.level = tuple.level
            comments.append(comment)
            getComments(from: (comment.comments, tuple.level + 1), to: &comments)
        }
    }
    
    private func fetchComment(for id: Int) {
        service.loadComments(with: id, completion: { [weak self] model in
            self?.prepareComments(from: model)
        }) { [weak self] error in
            self?.loadingLabel.setText(error.localizedDescription)
        }
    }
}

// MARK: Locale
extension CommentsInterfaceController {
    private enum Locale {
        static let title: String = "Comments"
        static let loading: String = "Loading..."
        static let noComments: String = "No comments"
    }
}
