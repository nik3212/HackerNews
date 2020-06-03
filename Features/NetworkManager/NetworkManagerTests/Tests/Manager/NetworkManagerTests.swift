//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import XCTest
@testable import NetworkManager

class NetworkManagerTests: XCTestCase {
    
    // MARK: Private Properties
    private let resource = MockResource()
    private let model = MockModel(id: "123", name: "Max")
    private var session: NetworkSession!
    private var networkManager: NetworkManagerProtocol!
    
    // MARK: Initialization
    override func setUp() {
        super.setUp()
        
        let data = try? JSONEncoder().encode(model)
        session = MockNetworkSession(data: data, urlResponse: nil, error: nil)
        networkManager = NetworkManager(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Tests
    func testThatNetworkManagerInitCorrect() {
        XCTAssertTrue(session === networkManager.session, "session and networkManager.session should be equal")
    }
    
    func testThatDecodingResponseIsCorrect() {
        networkManager.fetch(resource, completion: { mock in
            XCTAssertEqual(mock, self.model, "mock should be equal to self.mock")
        }, fail: { error in
            XCTFail(error.localizedDescription)
        })
    }
    
    func testThatDecodingResponseFailedWhenDataIsCorrupt() {
        let session = MockNetworkSession(data: nil, urlResponse: nil, error: nil)
        let networkManager = NetworkManager(session: session)
        
        networkManager.fetch(resource, completion: { _ in
            XCTFail("Loading ")
        }, fail: { error in
            if case NetworkError.decodingFailed = error {
                XCTAssert(true)
                return
            }
            XCTFail("error should be equal to NetworkError.decodingFailed")
        })
    }
    
    func testThatDecodingResponseFailedWhenErrorOccured() {
        let data = try? JSONEncoder().encode(model)
        let session = MockNetworkSession(data: data, urlResponse: nil, error: NetworkError.decodingFailed)
        let networkManager = NetworkManager(session: session)
        
        networkManager.fetch(resource, completion: { _ in
            XCTFail("Loading ")
        }, fail: { error in
            if case NetworkError.decodingFailed = error {
                XCTAssert(true)
                return
            }
            XCTFail("error should be equal to NetworkError.decodingFailed")
        })
    }
    
    func testThatLoadingFailedWhenAPIResourceParametersIsCorrupt() {
        let corruptResource = MockCorruptParametersModel()
        
        networkManager.fetch(corruptResource, completion: { _ in
            XCTFail("Loading with corrupt resource should be failed")
        }, fail: { _ in
            XCTAssert(true)
        })
    }
    
    func testThatLoadingFailedWhenAPIResourceParametersWithHeaderIsCorrupt() {
        let corruptResource = MockCorruptParametersWithHeaderResource()
        
        networkManager.fetch(corruptResource, completion: { _ in
            XCTFail("Loading with corrupt resource should be failed")
        }, fail: { _ in
            XCTAssert(true)
        })
    }
}
