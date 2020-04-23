//
//  NewsModel.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

struct NewsModel {
    
    /// The item's unique id.
    let id: Int
    
    /// The title of the story, poll or job.
    let title: String?
    
    /// The story's score, or the votes for a pollopt.
    let score: Int?
    
    /// The username of the item's author.
    let by: String?
    
    /// The URL of the story.
    let url: String?
    
    /// The ids of the item's comments, in ranked display order.
    var kids: [Int]?
    
    /// Creation date of the item, in Unix Time.
    var time: Int?
}

// MARK: Decodable
extension NewsModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case score
        case by
        case url
        case kids
        case time
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try? container.decode(String.self, forKey: .title)
        score = try? container.decode(Int.self, forKey: .score)
        by = try? container.decode(String.self, forKey: .by)
        url = try? container.decode(String.self, forKey: .url)
        kids = try? container.decode([Int].self, forKey: .kids)
        time = try? container.decode(Int.self, forKey: .time)
    }
}

extension NewsModel {
    func newsPublishTime() -> String? {
        guard let time = time else { return nil }
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        return Date().timeAgo(from: date)
    }
}
