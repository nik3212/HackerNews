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
        
    }
    
    class MockRouter: StoriesRouterInput {
        
    }
    
    class MockView: UIViewController, StoriesViewInput {
        func setupInitialState() {
            
        }
    }
}
