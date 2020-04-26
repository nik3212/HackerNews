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
        
    }
    
    class MockRouter: CommentsRouterInput {
        
    }
    
    class MockView: UIViewController, CommentsViewInput {
        func setupInitialState() {
            
        }
    }
}
