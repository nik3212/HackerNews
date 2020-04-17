//
//  Comment.swift
//  NetworkManager
//
//  Created by Никита Васильев on 11/11/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation
//
//public class Comment {
//    
//    /// The item's unique id.
//    public var id: Int?
//    
//    /// The username of the item's author.
//    public var author: String?
//    
//    /// The comment, story or poll text. HTML.
//    public var text: String?
//    
//    /// Nesting level
//    public var level: Int = 0
//    
//    /// Creation date of the item, in Unix Time.
//    public var time: Int?
//    
//    /// The ids of the item's comments, in ranked display order.
//    public var ids: [Int]?
//    
//    /// Reply comments
//    public var replies: [Comment] = []
//    
//    private var networkManager: NetworkEngine?
//    
//    init(networkManager: NetworkEngine = NetworkManager.shared, item: Item) {
//        self.id = item.id
//        self.author = item.by
//        self.text = item.text
//        self.time = item.time
//        self.ids = item.kids
//        self.networkManager = networkManager
//    }
//    
//    func getComments(completion: @escaping (Bool) -> Void) {
//        if let ids = ids {
//            if !ids.isEmpty {
//                var returnComments = [Comment]()
//                let commentsGroup = DispatchGroup()
//                
//                for id in ids {
//                    commentsGroup.enter()
//                    let currentIndentLevel = level
//                    
//                    networkManager?.retrieve(ids: [id]) { response in
//                        switch response {
//                        case .success(let items):
//                            let commentObject = Comment(item: items.first!)
//                            commentObject.level = currentIndentLevel + 1
//                            commentObject.getComments(completion: { _ in
//                                returnComments.append(commentObject)
//                                commentsGroup.leave()
//                            })
//                        case .error(let error):
//                            print(error.localizedDescription)
//                            commentsGroup.leave()
//                            completion(false)
//                        }
//                    }
//                }
//                
//                commentsGroup.notify(queue: .main) {
//                    self.replies = returnComments
//                    completion(true)
//                }
//            }
//        } else {
//            completion(false)
//        }
//    }
//    
//    public func numberOfComments() -> Int {
//        var numberOfComments = replies.count
//        for reply in replies {
//            numberOfComments += reply.numberOfComments()
//        }
//        return numberOfComments
//    }
//    
//    // swiftlint:disable force_cast
//    public func flattenedComments() -> Any {
//        var commentsArray: [Any] = [self]
//        for reply in replies {
//            commentsArray += reply.flattenedComments() as! [Any]
//        }
//        return commentsArray
//    }
//    // swiftlint:enable force_cast
//}
