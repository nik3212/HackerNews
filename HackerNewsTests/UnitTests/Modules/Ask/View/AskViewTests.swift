//
//  AskViewTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

class AskViewTests: QuickSpec {
    override func spec() {
        let output = AskPresenterMock()
        let view = R.storyboard.ask().instantiateViewController(type: AskViewController.self)

//        describe("Checking view configuration") {
//            it("view initializes properties") {
//                view.viewDidLoad()
//                expect(output.viewIsReadyIsCalled).to(equal(true))
//                expect(view.theme).to(equal(.light))
//                expect(view.extendedLayoutIncludesOpaqueBars).to(equal(true))
//            }
//        }
    }
}

extension AskViewTests {
    final class AskPresenterMock: AskViewOutput {
        var viewIsReadyIsCalled: Bool = false

        func viewIsReady() {
            self.viewIsReadyIsCalled = true
        }
        
        func getNumberOfRow() -> Int {
            return 0
        }
        
        func prefetch(at indexPath: IndexPath) {
            
        }
        
        func getModel(for indexPath: IndexPath) -> BaseCellViewModel {
            return PostCellViewModel(post: TestData.post, theme: .light, placeholderImage: .placeholder)
        }
        
        func didSelectRow(at row: Int) {
           
        }
        
        func refreshStories() {
            
        }
        
        func getEmptyDataSetTitle() -> String {
            return "Error Occured"
        }
        
        func getEmptyDataSetDecription() -> String {
            return "Some description"
        }
        
        func getEmptyDataSetImage() -> Image {
            return .connectionError
        }
    }
}
