//
//  Comment.swift
//  NetworkManager
//
//  Created by Никита Васильев on 11/11/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation

public class Comment {
    
    public var id: Int?
    
    public var author: String?
    
    public var text: String?
    
    public var level: Int = 0
    
    public var time: Int?
    
    public var ids: [Int]?
    
    public var replies: [Comment] = []
    
    init(item: Item) {
        self.id = item.id
        self.author = item.by
        self.text = item.text
        self.time = item.time
        self.ids = item.kids
    }
    
    func getComments(completion: @escaping (Bool) -> Void) {
        if let ids = ids {
            if ids.count > 0 {
                var returnComments = [Comment]()
                let commentsGroup = DispatchGroup()
                
                for id in ids {
                    commentsGroup.enter()
                    let currentIndentLevel = level
                    
                    NetworkManager.shared.retrieve(ids: [id]) { (response) in
                        switch response {
                        case .success(let items):
                            let commentObject = Comment(item: items.first!)
                            commentObject.level = currentIndentLevel + 1
                            commentObject.getComments(completion: { (_) in
                                returnComments.append(commentObject)
                                commentsGroup.leave()
                            })
                        case .error(let error):
                            print(error.localizedDescription)
                            commentsGroup.leave()
                            completion(false)
                        }
                    }
                }
                
                commentsGroup.notify(queue: .main) {
                    self.replies = returnComments
                    completion(true)
                }
            }
        } else {
            completion(false)
        }
    }
    
    public func numberOfComments() -> Int {
        var numberOfComments = replies.count
        for reply in replies {
            numberOfComments += reply.numberOfComments()
        }
        return numberOfComments
    }
    
    // swiftlint:disable force_cast
    public func flattenedComments() -> Any {
        var commentsArray: [Any] = [self]
        for reply in replies {
            commentsArray += reply.flattenedComments() as! [Any]
        }
        return commentsArray
    }
    // swiftlint:enable force_cast
}
