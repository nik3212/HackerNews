//
//  StoriesPresenterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class StoriesPresenterTests: QuickSpec {
    override func spec() {
        
    }
    
    class MockInteractor: StoriesInteractorInput {
        func fetchTopStories() {
            
        }
        
        func fetchBestStories() {
            
        }
        
        func fetchNewStories() {
            
        }
        
        func fetchPosts(with ids: [Int]) {
            
        }
        
        func cancleRequests() {
            
        }
    }
    
    class MockRouter: StoriesRouterInput {
        func openFilterModule(with models: [AlertActionModel]) {
            
        }
        
        func openCommentsModule(for post: PostModel) {
            
        }
        
        func openStories(from url: String) {
            
        }
    }
    
    class MockView: UIViewController, StoriesViewInput {
        func setupInitialState(title: String, theme: Theme, titles: [String]) {
            
        }
        
        func setUserInteractorEnabled(to state: Bool) {
            
        }
        
        func scrollContentToTop() {
            
        }
        
        func reloadData() {
            
        }
        
        func hideRefreshControl() {
            
        }
        
        func update(theme: Theme) {
            
        }
    }
}
