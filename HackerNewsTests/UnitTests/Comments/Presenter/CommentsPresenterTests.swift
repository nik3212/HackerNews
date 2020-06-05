//
//  CommentsPresenterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class CommentsPresenterTests: QuickSpec {
    override func spec() {
        
    }
    
    class MockInteractor: CommentsInteractorInput {
        func fetchComments(for id: Int) {
            
        }
    }
    
    class MockRouter: CommentsRouterInput {
        func openPost(from url: String) {
            
        }
    }
    
    class MockView: UIViewController, CommentsViewInput {
        func setupInitialState(title: String) {
            
        }
        
        func displayMessage(text: String) {
            
        }
        
        func reloadData() {
            
        }
        
        func showActivityIndicator() {
            
        }
        
        func hideActivityIndicator() {
            
        }
        
        func insertRows(at indexPaths: [IndexPath]) {
            
        }
        
        func update(theme: Theme) {
            
        }
    }
}
