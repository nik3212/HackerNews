//
//  FDataSnapshotMock.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 10/09/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation
import Firebase

class FDataSnapshotMock: FDataSnapshot {
    let k: String
    let v: Any
    
    override var key: String! {
        return k
    }
    
    override var value: Any! {
        return v
    }
    
    init(key: String, value: Any) {
        self.k = key
        self.v = value
    }
}
