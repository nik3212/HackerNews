//
//  Item.swift
//  NetworkManager
//
//  Created by Никита Васильев on 29/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation
import Firebase

public class Item {
    
    // MARK: - Properties
    
    /// The username of the item's author.
    public var author: String?
    
    /// The item's unique id.
    public var id: Int?
    
    /// The URL of the story.
    public var url: URL?
    
    /// The title of the story, poll or job.
    public var title: String?
    
    /// The story's score, or the votes for a pollopt.
    public var score: Int?
    
    /// true if the item is deleted.
    public var isDeleted: Bool?
    
    /// The type of item. One of "job", "story", "comment", "poll", or "pollopt".
    public var type: [String]?
    
    /// Creation date of the item, in Unix Time.
    public var time: Date?
    
    /// The comment, story or poll text. HTML.
    public var text: String?
    
    /// true if the item is dead.
    public var isDead: Bool?
    
    /// The comment's parent: either another comment or the relevant story.
    public var parent: Int?
    
    /// The pollopt's associated poll.
    public var poll: Int?
    
    /// The ids of the item's comments, in ranked display order.
    public var kids: [Int]?
    
    /// A list of related pollopts, in display order.
    public var parts: [Int]?
    
    /// In the case of stories or polls, the total comment count.
    public var descendants: Int?
    
    // MARK: - Initialization
    
    public required init?(snapshot: FDataSnapshot) {
        guard let value = snapshot.value as? [String: AnyObject]
        else { return nil }
        
        id = value["id"] as? Int
        author = value["by"] as? String
        url = value["url"] as? URL
        title = value["title"] as? String
        score = value["score"] as? Int
        isDeleted = value["deleted"] as? Bool
        type = value["type"] as? [String]
        time = value["time"] as? Date
        text = value["text"] as? String
        isDead = value["dead"] as? Bool
        parent = value["parent"] as? Int
        poll = value["poll"] as? Int
        kids = value["kids"] as? [Int]
        parts = value["parts"] as? [Int]
        descendants = value["descendants"] as? Int
    }
}

// MARK: - Equatable

extension Item: Equatable {
    public static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
