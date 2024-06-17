//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import Foundation

struct Comment: Decodable, Equatable {
    let id: Int
    let author: String?
    let text: String?
    let time: Int?
    let kids: [Int]

    var comments: [Comment] = []

    enum CodingKeys: CodingKey {
        case id
        case by
        case text
        case time
        case kids
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        author = try container.decodeIfPresent(String.self, forKey: .by)
        text = try container.decodeIfPresent(String.self, forKey: .text)
        time = try container.decodeIfPresent(Int.self, forKey: .time)
        kids = try container.decodeIfPresent([Int].self, forKey: .kids) ?? []
    }
}
