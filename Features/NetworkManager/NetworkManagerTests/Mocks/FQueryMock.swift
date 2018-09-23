//
//  FQueryMock.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 10/09/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation
import Firebase

class FQueryMock: FQuery {
    let firebaseMock: FirebaseMock
    
    init(firebaseMock: FirebaseMock) {
        self.firebaseMock = firebaseMock
    }
    
    override func observe(_ eventType: FEventType, with block: ((FDataSnapshot?) -> Void)!) -> UInt {
        return UInt(firebaseMock.handlers.count)
    }
    
    override func observeSingleEvent(of eventType: FEventType, with block: ((FDataSnapshot?) -> Void)!, withCancel cancelBlock: ((Error?) -> Void)!) {
        firebaseMock.observeSingleEvent(of: eventType, with: block, withCancel: cancelBlock)
    }
    
}
