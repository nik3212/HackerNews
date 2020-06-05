//
//  StoriesInteractorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class StoriesInteractorTests: QuickSpec {
    override func spec() {
        
    }
    
    class MockPresenter: StoriesInteractorOutput {
        func fetchTopStoriesSuccess(ids: [Int]) {
            
        }
        
        func fetchTopStoriesFailed(error: Error) {
            
        }
        
        func fetchBestStoriesSuccess(ids: [Int]) {
            
        }
        
        func fetchBestStoriesFailed(error: Error) {
            
        }
        
        func fetchNewStoriesSuccess(ids: [Int]) {
            
        }
        
        func fetchNewStoriesFailed(error: Error) {
            
        }
        
        func fetchItemsSuccess(_ items: [PostModel]) {
            
        }
        
        func fetchItemsFailed(error: Error) {
            
        }
    }
}
