//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import Foundation

struct Post: Decodable, Equatable, Identifiable {
    /// The item's unique id.
    let id: Int

    /// The title of the story, poll or job.
    let title: String?

    /// The story's score, or the votes for a pollopt.
    let score: Int?

    /// The username of the item's author.
    let author: String?

    /// The URL of the story.
    let url: String?

    /// The ids of the item's comments, in ranked display order.
    var kids: [Int]

    /// Creation date of the item, in Unix Time.
    var time: Int

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case score
        case by
        case url
        case kids
        case time
    }

    // MARK: Initialization

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try? container.decode(String.self, forKey: .title)
        score = try? container.decode(Int.self, forKey: .score)
        author = try? container.decode(String.self, forKey: .by)
        url = try? container.decode(String.self, forKey: .url)
        kids = (try? container.decode([Int].self, forKey: .kids)) ?? []
        time = (try? container.decode(Int.self, forKey: .time)) ?? .zero
    }
}
