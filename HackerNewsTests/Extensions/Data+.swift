//
//  Data+.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 06.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

extension Data {
    func json(deletingKeyPaths keyPaths: String...) throws -> Data {
        let decoded = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as AnyObject
        
        for keyPath in keyPaths {
            decoded.setValue(nil, forKeyPath: keyPath)
        }
        
        return try JSONSerialization.data(withJSONObject: decoded)
    }
}
