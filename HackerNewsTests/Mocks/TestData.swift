//
//  TestData.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 05.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

@testable import HackerNews

enum TestData: String {
    case storyJSON = """
    {
        \"id\": 8863,
        \"by\": \"name\",
        \"descendants\": 71,
        \"kids\": [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940 ],
        \"score\": 111,
        \"time\": 1175714200,
        \"title\": \"My YC app: Dropbox - Throw away your USB drive\",
        \"url\": \"http://www.getdropbox.com/u/2/screencast.html\"
    }
    """
    
    case storyWithoutIdJSON = """
    {
        \"by\": \"name\",
        \"descendants\": 71,
        \"kids\": [ 8952, 9224, 8917, 8884, 8887, 8943, 8869, 8958, 9005, 9671, 8940 ],
        \"score\": 111,
        \"time\": 1175714200,
        \"title\": \"My YC app: Dropbox - Throw away your USB drive\",
        \"url\": \"http://www.getdropbox.com/u/2/screencast.html\"
    }
    """
    
    case commentWithoutJSON = """
    {
      \"by\" : \"norvig\",
      \"kids\" : [ 2922097, 2922429, 2924562, 2922709, 2922573, 2922140, 2922141 ],
      \"parent\" : 2921506,
      \"text\" : \"Aw shucks, guys ... you make me blush with your compliments.",
      \"time\" : 1314211127
    }
    """
    
    case commentJSON = """
    {
      \"by\" : \"norvig\",
      \"id\" : 2921983,
      \"kids\" : [ 2922097, 2922429, 2924562, 2922709, 2922573, 2922140, 2922141 ],
      \"parent\" : 2921506,
      \"text\" : \"Aw shucks, guys ... you make me blush with your compliments.",
      \"time\" : 1314211127,
      \"type\" : \"comment\"
    }
    """
    
    var data: Data {
        return Data(self.rawValue.utf8)
    }
}

extension TestData {
    // swiftlint:disable force_try
    static var post: PostModel {
        return try! JSONDecoder().decode(PostModel.self, from: TestData.storyJSON.data)
    }
    // swiftlint:enable force_try
}
