//
//  StoriesInteractorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble
import HNService

@testable import HackerNews

final class StoriesInteractorSpec: QuickSpec {
    override func spec() {
        var interactor: StoriesInteractor!
        var output: MockPresenter!
        var networkService: HNServiceMock!
        
        beforeEach {
            interactor = StoriesInteractor()
            output = MockPresenter()
            networkService = HNServiceMock()
            
            interactor.output = output
            interactor.networkService = networkService
        }
        
        describe("fetch ids") {
            context("top stories") {
                beforeEach {
                    interactor.fetchIds(for: .top)
                }
                
                context("success") {
                    beforeEach {
                        networkService.fetchIdsCompletion?(Array(0...50))
                    }
                    
                    it("should call output to present all ids") {
                        expect(networkService.fetchIdsCalled).to(beTrue())
                        expect(output.fetchedStoriesIds).to(equal(Array(0...50)))
                    }
                }
                
                context("failed") {
                    beforeEach {
                        networkService.fetchIdsFail?(UnitTestError())
                    }
                    
                    it("should call output to display error") {
                        expect(networkService.fetchIdsCalled).to(beTrue())
                        expect(output.fetchedError).to(beAKindOf(UnitTestError.self))
                    }
                }
            }
        }
    }
}

// MARK: Mocks
extension StoriesInteractorSpec {
    final class MockPresenter: StoriesInteractorOutput {
        var fetchedStoriesIds: [Int] = []
        var fetchedError: Error?
        
        var fetchedPosts: [PostModel] = []
        var fetchedPostsError: Error?
        
        func fetchIdsSuccess(_ ids: [Int]) {
            fetchedStoriesIds = ids
        }
        
        func fetchIdsFail(error: Error) {
            fetchedError = error
        }
        
        func fetchItemsSuccess(_ items: [PostModel]) {
            fetchedPosts = items
        }
        
        func fetchItemsFailed(error: Error) {
            fetchedPostsError = error
        }
    }
}
