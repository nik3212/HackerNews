//
//  String+Localized.swift
//  HackerNewsWatch WatchKit Extension
//
//  Created by Никита Васильев on 21.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localizedFormat(arguments: CVarArg...) -> String {
        return String(format: localized(), arguments: arguments)
    }
}
