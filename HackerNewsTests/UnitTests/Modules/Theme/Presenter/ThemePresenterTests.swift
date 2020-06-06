//
//  ThemePresenterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 27/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class ThemePresenterTests: QuickSpec {
    override func spec() {
        
    }
    
    class MockInteractor: ThemeInteractorInput {
        
    }
    
    class MockRouter: ThemeRouterInput {
        func dismiss() {
            
        }
    }
    
    class MockView: UIViewController, ThemeViewInput {
        func setupInitialState(title: String, theme: Theme) {
            
        }
        
        func reloadData() {
            
        }
        
        func update(theme: Theme) {
            
        }
    }
}
