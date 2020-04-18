//
//  APIRequestTests.swift
//  NetworkManagerTests
//
//  Created by Никита Васильев on 18.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import XCTest
@testable import NetworkManager

class APIRequestTests: XCTestCase {
    
    // MARK: Private Properties
    private let resource = MockResource()
    private let model = MockModel(id: "123", name: "Max")
    private var apiRequest: APIRequest<MockResource>!
    private var session: NetworkSession!
    
    // MARK: Initialization
    override func setUp() {
        super.setUp()
        
        let data = try? JSONEncoder().encode(model)
        session = MockNetworkSession(data: data, urlResponse: nil, error: nil)
        apiRequest = APIRequest(resource: resource, session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testThatAPIRequestInitCorrect() throws {
        XCTAssertTrue(session === apiRequest.session, "session and network should be equal")
        XCTAssertEqual(resource, apiRequest.resource, "resource in apiRequest should be equal to resource")
    }
    
    func testThatDecodingResponseIsCorrect() {
        apiRequest.load(resource, completion: { mock in
            XCTAssertEqual(mock, self.model, "mock should be equal to self.mock")
        }) { error in
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThatDecodingResponseFailedWhenDataIsCorrupt() {
        let session = MockNetworkSession(data: nil, urlResponse: nil, error: nil)
        let apiRequest = APIRequest(resource: resource, session: session)
        
        apiRequest.load(resource, completion: { model in
            XCTFail("Loading ")
        }) { error in
            if case NetworkError.decodingFailed = error {
                XCTAssert(true)
                return
            }
            XCTFail("error should be equal to NetworkError.decodingFailed")
        }
    }
    
    func testThatDecodingResponseFailedWhenErrorOccured() {
        let data = try? JSONEncoder().encode(model)
        let session = MockNetworkSession(data: data, urlResponse: nil, error: NetworkError.decodingFailed)
        let apiRequest = APIRequest(resource: resource, session: session)
        
        apiRequest.load(resource, completion: { model in
            XCTFail("Loading ")
        }) { error in
            if case NetworkError.decodingFailed = error {
                XCTAssert(true)
                return
            }
            XCTFail("error should be equal to NetworkError.decodingFailed")
        }
    }
    
    func testThatLoadingFailedWhenAPIResourceParametersIsCorrupt() {
        let corruptResource = MockCorruptParametersModel()
        apiRequest.load(corruptResource, completion: { _ in
            XCTFail("Loading with corrupt resource should be failed")
        }) { _ in
            XCTAssert(true)
        }
    }
    
    func testThatLoadingFailedWhenAPIResourceParametersWithHeaderIsCorrupt() {
        let corruptResource = MockCorruptParametersWithHeaderResource()
        apiRequest.load(corruptResource, completion: { _ in
            XCTFail("Loading with corrupt resource should be failed")
        }) { _ in
            XCTAssert(true)
        }
    }
}
