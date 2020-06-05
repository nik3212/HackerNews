//
//  AskPresenterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class AskPresenterTests: QuickSpec {
    override func spec() {
        
    }
    
    class MockInteractor: AskInteractorInput {
        func fetchAskIds() {
            
        }
        
        func fetchPosts(with ids: [Int]) {
            
        }
    }
    
    class MockRouter: AskRouterInput {
        func openCommentsModule(for post: PostModel) {
            
        }
    }
    
    class MockView: UIViewController, AskViewInput {
        func setupInitialState(title: String, theme: Theme) {
            
        }
        
        func setUserInteractorEnabled(to state: Bool) {
            
        }
        
        func reloadData() {
            
        }
        
        func hideRefreshControl() {
            
        }
        
        func update(theme: Theme) {
            
        }
    }
}
