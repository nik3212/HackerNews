//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 29/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import XCTest
import Firebase

@testable import NetworkManager

class NetworkManagerTests: XCTestCase {
    
    var networkManager: NetworkManager!
    var firebase: FirebaseMock!
    
    override func setUp() {
        super.setUp()
        firebase = FirebaseMock()
        networkManager = NetworkManager.shared
    }
    
    override func tearDown() {
        networkManager = nil
        firebase = nil
        super.tearDown()
    }
    
    func testThatFirebaseContainsValidIds() {
        let snap = FDataSnapshotMock(key: "topstories",
                                     value: [ 9129911, 9129199, 9127761, 9128141, 9128264, 9127792, 9129248, 9127092, 9128367 ])
        firebase.add(snap: snap)
        networkManager.setup(with: firebase)

        networkManager.getIds(type: .top) { data in
            switch data {
            case .success(let items):
                XCTAssertEqual(items.count, 9, "Items should contains 9 values")
                XCTAssertEqual(items.first!, 9129911, "Items should be equal")
            case .error(let error):
                XCTFail("\(error.localizedDescription)")
            }
        }
    }
    
    func testThatFirebaseContainsValidData() {
        let data: [String: Any] = ["title": "Amazon pulled an Apple on the smart home",
                                   "by": "imartin2k",
                                   "descendants": 62,
                                   "id": 18052121,
                                   "kids": [18052538, 18052408, 18052576, 18052287, 18052478,
                                            18052618, 18052423, 18052718, 18052595, 18052235,
                                            18052721, 18052608, 18052398],
                                   "score": 67,
                                   "time": 1537724011,
                                   "type": "story"]
        
        let snap = FDataSnapshotMock(key: "18052121", value: data)
        
        firebase.add(snap: snap)
        networkManager.storyLimit = 1
        networkManager.setup(with: firebase)
        
        networkManager.retrieve(ids: [18052121]) { response in
            switch response {
            case .success(let items):
                XCTAssertEqual(items.count, 1, "Items should be contains one item")
                XCTAssertEqual(items.first?.by, "imartin2k", "Names should be equal")
                XCTAssertEqual(items.first?.id, 18052121, "IDs should be equal")
            case .error(let error):
                XCTFail("\(error.localizedDescription)")
            }
        }
    }
}
