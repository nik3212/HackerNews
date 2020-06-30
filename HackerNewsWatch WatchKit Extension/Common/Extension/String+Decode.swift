//
//  String+Decode.swift
//  HackerNewsWatch WatchKit Extension
//
//  Created by Никита Васильев on 21.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string
        
        return decoded?.trimmingCharacters(in: .whitespacesAndNewlines) ?? self
    }
}
