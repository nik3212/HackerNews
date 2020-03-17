//
//  SettingsPresenterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 18/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class SettingsPresenterTests: QuickSpec {
    override func spec() {
        
    }
    
    class MockInteractor: SettingsInteractorInput {
        
    }
    
    class MockRouter: SettingsRouterInput {
        
    }
    
    class MockView: UIViewController, SettingsViewInput {
        func setupInitialState() {
            
        }
    }
}
