//
//  PostViewerPresenterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 23/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class PostViewerPresenterTests: QuickSpec {
    override func spec() {
        
    }
    
    class MockInteractor: PostViewerInteractorInput {
        
    }
    
    class MockRouter: PostViewerRouterInput {
        
    }
    
    class MockView: UIViewController, PostViewerViewInput {
        func setupInitialState() {
            
        }
    }
}
