//
//  ShowInteractorTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 07.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

final class ShowInteractorTests: QuickSpec {
    override func spec() {
        var interactor: ShowInteractor!
        var output: MockPresenter!
        var networkService: HNServiceMock!
        
        beforeEach {
            interactor = ShowInteractor()
            output = MockPresenter()
            networkService = HNServiceMock()
            
            interactor.output = output
            interactor.networkService = networkService
        }
        
        describe("fetch ids") {
            context("success") {
                beforeEach {
                    interactor.fetchShowIds()
                    networkService.loadShowStoriesCompletion?(Array(0...50))
                }
                
                it("should call output to present all ids") {
                    expect(networkService.loadShowStoriesCalled).to(beTrue())
                    expect(output.fetchedIds).to(equal(Array(0...50)))
                }
            }
            
            context("failed") {
                beforeEach {
                    interactor.fetchShowIds()
                    networkService.loadShowStoriesFail?(UnitTestError())
                }
                
                it("should call output to display error") {
                    expect(networkService.loadShowStoriesCalled).to(beTrue())
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
extension ShowInteractorTests {
    final class MockPresenter: ShowInteractorOutput {
        var fetchedIds: [Int] = []
        var fetchedIdsError: Error?
        var fetchedPosts: [PostModel] = []
        var fetchedPostsError: Error?
        
        func fetchShowStoriesSuccess(ids: [Int]) {
            fetchedIds = ids
        }
        
        func fetchShowStoriesFailed(error: Error) {
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
