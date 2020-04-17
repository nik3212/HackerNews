//
//  String+Localized.swift
//  HackerNews
//
//  Created by Никита Васильев on 17.04.2020.
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
