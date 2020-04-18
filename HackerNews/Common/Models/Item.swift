//
//  Item.swift
//  NetworkManager
//
//  Created by Никита Васильев on 29/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//
//
import Foundation

// sourcery: ItemRepresentable
public struct Item {
    
    // MARK: - Properties
    
    /// The username of the item's author.
    public var by: String?
    
    /// The item's unique id.
    public var id: Int?
    
    /// The URL of the story.
    public var url: String?
    
    /// The title of the story, poll or job.
    public var title: String?
    
    /// The story's score, or the votes for a pollopt.
    public var score: Int?
    
    /// true if the item is deleted.
    public var isDeleted: Bool?
    
    /// The type of item. One of "job", "story", "comment", "poll", or "pollopt".
    public var type: [String]?
    
    /// Creation date of the item, in Unix Time.
    public var time: Int?
    
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
}
    
// sourcery:inline:auto:Item.ItemRepresentable
extension Item: Decodable {
    private enum CodingKeys: String, CodingKey {
        case by
        case id
        case url
        case title
        case score
        case isDeleted
        case type
        case time
        case text
        case isDead
        case parent
        case poll
        case kids
        case parts
        case descendants
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        by = try? container.decode(String.self, forKey: .by)
        id = try? container.decode(Int.self, forKey: .id)
        url = try? container.decode(String.self, forKey: .url)
        title = try? container.decode(String.self, forKey: .title)
        score = try? container.decode(Int.self, forKey: .score)
        isDeleted = try? container.decode(Bool.self, forKey: .isDeleted)
        type = try? container.decode([String].self, forKey: .type)
        time = try? container.decode(Int.self, forKey: .time)
        text = try? container.decode(String.self, forKey: .text)
        isDead = try? container.decode(Bool.self, forKey: .isDead)
        parent = try? container.decode(Int.self, forKey: .parent)
        poll = try? container.decode(Int.self, forKey: .poll)
        kids = try? container.decode([Int].self, forKey: .kids)
        parts = try? container.decode([Int].self, forKey: .parts)
        descendants = try? container.decode(Int.self, forKey: .descendants)
    }
}
// sourcery:end
