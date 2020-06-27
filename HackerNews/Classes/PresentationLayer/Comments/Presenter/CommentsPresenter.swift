//
//  CommentsPresenter.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import UIKit
import struct HNService.CommentModel
import struct HNService.PostModel

final class CommentsPresenter {
    // MARK: Public Properties
    weak var view: CommentsViewInput!
    var interactor: CommentsInteractorInput!
    var router: CommentsRouterInput!
    var themeManager: ThemeManagerProtocol!
    var post: PostModel!
    
    // MARK: Private Properties
    private var commentIds = Queue<Int>()
    private var commentTexts = [String]()
    private var comments: [CommentModel] = []
    private var loadingCommentId: Int?
    
    // MARK: Life Cycle
    deinit {
        themeManager.removeObserver(self)
    }
    
    // MARK: Private Methods
    private func fetchComments() {
        guard let id = commentIds.dequeue(), loadingCommentId == nil else {
            self.view.setLoadingIndicator(to: false)
            return
        }
        self.loadingCommentId = id
        self.interactor.fetchComments(for: id)
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
        
        var indexPaths: [IndexPath] = []
        var row = self.comments.count
        
        sortedComments.forEach { model in
            if model.deleted {
                return
            }
            
            if let text = model.text {
                self.commentTexts.append(text.htmlDecoded)
            }
            
            self.comments.append(model)
            
            let indexPath = IndexPath(row: row, section: Sections.comments.rawValue)
            indexPaths.append(indexPath)
            row += 1
        }
        
        self.loadingCommentId = nil
        self.view.setLoadingIndicator(to: false)
        self.view.hideActivityIndicator()
        self.view.insertRows(at: indexPaths)
    }
    
    private func getComments(from tuple: (graph: [CommentModel], level: Int), to comments: inout [CommentModel]) {
        for var comment in tuple.graph {
            comment.level = tuple.level
            comments.append(comment)
            getComments(from: (comment.comments, tuple.level + 1), to: &comments)
        }
    }
}

// MARK: CommentsViewOutput
extension CommentsPresenter: CommentsViewOutput {
    func viewIsReady() {
        view.setupInitialState(title: CommentsConstants.title.localized())
        view.showActivityIndicator()
        view.update(theme: themeManager.theme)
        themeManager.addObserver(self)
        
        if post.kids.isEmpty {
            view.displayMessage(text: CommentsConstants.noComments.localized())
            view.hideActivityIndicator()
        } else {
            commentIds.enqueue(post.kids)
            fetchComments()
        }
    }
    
    func numbersOfSection() -> Int {
        return 2
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let sectionType = Sections(rawValue: section) else { return 0 }
        
        switch sectionType {
        case .info:
            return 1
        case .comments:
            return loadingCommentId != nil ? 0 : comments.count
        }
    }
    
    func getPost() -> PostModel? {
        return post
    }
    
    func getModel(for indexPath: IndexPath) -> BaseCellViewModel {
        guard let sectionType = Sections(rawValue: indexPath.section) else { fatalError("") }
        
        switch sectionType {
        case .info:
            return PostCellViewModel(post: post, theme: themeManager.theme, placeholderImage: .placeholder)
        case .comments:
            return CommentCellViewModel(comment: comments[indexPath.row],
                                        text: commentTexts[indexPath.row],
                                        theme: themeManager.theme)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let section = Sections(rawValue: indexPath.section) else { return }
        
        if section == .info, let url = post.url {
            router.openPost(from: url)
        }
    }
    
    func willDisplay(for indexPath: IndexPath) {
        guard let sectionType = Sections(rawValue: indexPath.section) else { return }
        
        let isLastRow = sectionType == .comments && indexPath.row == comments.count - 1
        
        if isLastRow && !commentIds.isEmpty {
            view.setLoadingIndicator(to: true)
            fetchComments()
        }
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
}

// MARK: CommentsInteractorOutput
extension CommentsPresenter: CommentsInteractorOutput {
    func fetchCommentsSuccess(_ comment: CommentModel) {
        prepareComments(from: comment)
    }
    
    func fetchCommentsFail(error: Error) {
        
    }
}

// MARK: CommentsModuleInput
extension CommentsPresenter: CommentsModuleInput {
    func showDetail(from viewController: UIViewController) {
        view.showDetail(from: viewController)
    }
}

extension CommentsPresenter: ThemeObserver {
    func themeDidChange(_ theme: Theme) {
        view.update(theme: theme)
    }
}

// MARK: Constants
extension CommentsPresenter {
    private enum CommentsConstants {
        static let title: String = "Comments"
        static let noComments: String = "No comments"
    }
}

// MARK: Sections
extension CommentsPresenter {
    private enum Sections: Int {
        case info
        case comments
    }
}
