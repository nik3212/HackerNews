//
//  AskInteractorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class AskInteractorTests: QuickSpec {
    override func spec() {
        
    }
    
    class MockPresenter: AskInteractorOutput {
        func fetchAskSuccess(ids: [Int]) {
            
        }
        
        func fetchAskFailed(error: Error) {
            
        }
        
        func fetchPostsSuccess(_ posts: [PostModel]) {
            
        }
        
        func fetchPostsFailed(error: Error) {
            
        }
    }
}