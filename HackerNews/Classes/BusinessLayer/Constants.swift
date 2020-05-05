//
//  Constants.swift
//  HackerNews
//
//  Created by Никита Васильев on 05.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

struct Constants {
    struct Settings {
        static let theme: String = "Theme"
    }
    
    struct Links {
        static let feedbackURL: String = "https://www.github.com/nik3212/HackerNews"
        static let appstoreURL: String = "itms-apps://itunes.apple.com/app/id1442922669"
        static let imageExtractorURL: String = "https://image-extractor.now.sh/?url="
    }
    
    struct Endpoints {
        static let base = "https://hacker-news.firebaseio.com/v0/"
        static let topStories = "topstories.json"
        static let bestStories = "beststories.json"
        static let newStories = "newstories.json"
        static let askStories = "askstories.json"
        static let showStories = "showstories.json"
    }
}
