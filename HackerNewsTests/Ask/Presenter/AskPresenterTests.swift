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
        
    }
    
    class MockRouter: AskRouterInput {
        
    }
    
    class MockView: UIViewController, AskViewInput {
        func setupInitialState() {
            
        }
    }
}
