//
//  FirebaseMock.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 07/09/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import Foundation
import Firebase

@testable import NetworkManager

class FirebaseMock: Firebase {
    
    var handlers = [FEventType: FDataSnapshot]()
    var fakeKey: String?
    
    override var key: String! {
        return fakeKey
    }
    
    convenience override init() {
        self.init(fakeKey: nil)
    }
    
    init(fakeKey: String?) {
        super.init()
        self.fakeKey = fakeKey
    }
    
    override func child(byAppendingPath pathString: String!) -> Firebase! {
        fakeKey = pathString
        return self
    }
    
    override func queryLimited(toFirst limit: UInt) -> FQuery! {
        return FQueryMock(firebaseMock: self)
    }
    
    override func queryOrderedByKey() -> FQuery! {
        return FQueryMock(firebaseMock: self)
    }
    
    override func observeSingleEvent(of eventType: FEventType, with block: ((FDataSnapshot?) -> Void)!, withCancel cancelBlock: ((Error?) -> Void)!) {
        block(handlers[eventType]!)
    }
    
    func add(snap: FDataSnapshot) {
        handlers = [.value: snap]
    }
 
    func remove(snap: FDataSnapshot) {
        handlers = [.childRemoved: snap]
    }
    
    func change(snap: FDataSnapshot) {
        handlers = [.childChanged: snap]
    }
    
}
