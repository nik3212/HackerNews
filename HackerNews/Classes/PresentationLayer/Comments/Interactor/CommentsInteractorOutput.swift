//
//  CommentsInteractorOutput.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

protocol CommentsInteractorOutput: class {    
    func fetchCommentsSuccess(_ comment: CommentModel)
    func fetchCommentsFail(error: Error)
}
