//
//  AskInteractorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble
import HNService

@testable import HackerNews

class AskInteractorSpec: QuickSpec {
    override func spec() {
        var interactor: AskInteractor!
        var output: MockPresenter!
        var networkService: HNServiceMock!
        
        beforeEach {
            interactor = AskInteractor()
            output = MockPresenter()
            networkService = HNServiceMock()
            
            interactor.output = output
            interactor.networkService = networkService
        }
        
        describe("fetch ids") {
            context("success") {
                beforeEach {
                    interactor.fetchAskIds()
                    networkService.loadAskStoriesCompletion?(Array(0...50))
                }
                
                it("should call output to present all ids") {
                    expect(networkService.loadAskStoriesCalled).to(beTrue())
                    expect(output.fetchedIds).to(equal(Array(0...50)))
                }
            }
            
            context("failed") {
                beforeEach {
                    interactor.fetchAskIds()
                    networkService.loadAskStoriesFail?(UnitTestError())
                }
                
                it("should call output to display error") {
                    expect(networkService.loadAskStoriesCalled).to(beTrue())
                    expect(output.fetchedIdsError).to(beAKindOf(UnitTestError.self))
                }
            }
        }
        
        describe("fetch posts") {
            context("success") {
                beforeEach {
                    interactor.fetchPosts(with: Array(0...50))
                    networkService.loadPostsCompletion?([TestData.post])
                }
                
                it("should call output to present all ids") {
                    expect(networkService.loadPostsCalled).to(beTrue())
                    expect(output.fetchedPosts.count).to(equal(1))
                    expect(output.fetchedPosts).to(equal([TestData.post]))
                }
            }
            
            context("failed") {
                beforeEach {
                    interactor.fetchPosts(with: Array(0...50))
                    networkService.loadPostsFail?(UnitTestError())
                }
                
                it("should call output to display error") {
                    expect(networkService.loadPostsCalled).to(beTrue())
                    expect(output.fetchedPostsError).to(beAKindOf(UnitTestError.self))
                }
            }
        }
    }
}

// MARK: Mocks
extension AskInteractorSpec {
    final class MockPresenter: AskInteractorOutput {
        var fetchedIds: [Int] = []
        var fetchedIdsError: Error?
        var fetchedPosts: [PostModel] = []
        var fetchedPostsError: Error?
        
        func fetchAskSuccess(ids: [Int]) {
            fetchedIds = ids
        }
        
        func fetchAskFailed(error: Error) {
            fetchedIdsError = error
        }
        
        func fetchPostsSuccess(_ posts: [PostModel]) {
            fetchedPosts = posts
        }
        
        func fetchPostsFailed(error: Error) {
            fetchedPostsError = error
        }
    }
}
