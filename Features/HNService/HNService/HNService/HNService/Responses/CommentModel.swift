//
//  CommentModel.swift
//  NetworkManager
//
//  Created by Никита Васильев on 11/11/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation

public struct CommentModel {
    public let id: Int
    public let by: String?
    public let text: String?
    public let time: Int?
    public let ids: [Int]?
    public let kids: [Int]
    public let deleted: Bool
    
    public var level: Int = 0
    public var comments: [CommentModel] = []
}

// MARK: Decodable
extension CommentModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case by
        case text
        case time
        case kids
        case ids
        case deleted
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        by = try? container.decode(String.self, forKey: .by)
        text = try? container.decode(String.self, forKey: .text)
        time = try? container.decode(Int.self, forKey: .time)
        kids = (try? container.decode([Int].self, forKey: .kids)) ?? []
        ids = try? container.decode([Int].self, forKey: .ids)
        deleted = (try? container.decode(Bool.self, forKey: .deleted)) ?? false
    }
}

extension CommentModel {
//    func commentPublishTime() -> String? {
//        guard let time = time else { return nil }
//        let date = Date(timeIntervalSince1970: TimeInterval(time))
//        return Date().timeAgo(from: date)
//    }
}
