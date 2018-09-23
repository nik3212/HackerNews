//
//  Item.swift
//  NetworkManager
//
//  Created by Никита Васильев on 29/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation
import Firebase

// sourcery: ItemRepresentable
public class Item {
    
    // MARK: - Properties
    
    /// The username of the item's author.
    public var by: String?
    
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

    // sourcery:inline:auto:Item.ItemRepresentable
    public required init?(snapshot: FDataSnapshot) {
        guard let values = snapshot.value as? [String: AnyObject] else { return nil }
        by = values["by"] as? String
        id = values["id"] as? Int
        url = values["url"] as? URL
        title = values["title"] as? String
        score = values["score"] as? Int
        isDeleted = values["isDeleted"] as? Bool
        type = values["type"] as? [String]
        time = values["time"] as? Date
        text = values["text"] as? String
        isDead = values["isDead"] as? Bool
        parent = values["parent"] as? Int
        poll = values["poll"] as? Int
        kids = values["kids"] as? [Int]
        parts = values["parts"] as? [Int]
        descendants = values["descendants"] as? Int
    }
   // sourcery:end

}

// MARK: - Equatable

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id
    }
}
