//
//  StoriesInteractorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

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
                    interactor.fetchTopStories()
                }
                
                context("success") {
                    beforeEach {
                        networkService.loadTopStoriesCompletion?(Array(0...50))
                    }
                    
                    it("should call output to present all ids") {
                        expect(networkService.loadTopStoriesCalled).to(beTrue())
                        expect(output.fetchedTopStoriesIds).to(equal(Array(0...50)))
                    }
                }
                
                context("failed") {
                    beforeEach {
                        networkService.loadTopStoriesFail?(UnitTestError())
                    }
                    
                    it("should call output to display error") {
                        expect(networkService.loadTopStoriesCalled).to(beTrue())
                        expect(output.fetchedTopStoriesIdsError).to(beAKindOf(UnitTestError.self))
                    }
                }
            }
            
            context("best stories") {
                beforeEach {
                    interactor.fetchBestStories()
                }
                
                context("success") {
                    beforeEach {
                        networkService.loadBestStoriesCompletion?(Array(0...50))
                    }
                    
                    it("should call output to present all ids") {
                        expect(networkService.loadBestStoriesCalled).to(beTrue())
                        expect(output.fetchedBestStoriesIds).to(equal(Array(0...50)))
                    }
                }
                
                context("failed") {
                    beforeEach {
                        networkService.loadBestStoriesFail?(UnitTestError())
                    }
                    
                    it("should call output to display error") {
                        expect(networkService.loadBestStoriesCalled).to(beTrue())
                        expect(output.fetchedBestStoriesIdsError).to(beAKindOf(UnitTestError.self))
                    }
                }
            }
            
            context("new stories") {
                beforeEach {
                    interactor.fetchNewStories()
                }
                
                context("success") {
                    beforeEach {
                        networkService.loadNewStoriesCompletion?(Array(0...50))
                    }
                    
                    it("should call output to present all ids") {
                        expect(networkService.loadNewStoriesCalled).to(beTrue())
                        expect(output.fetchedNewStoriesIds).to(equal(Array(0...50)))
                    }
                }
                
                context("failed") {
                    beforeEach {
                        networkService.loadNewStoriesFail?(UnitTestError())
                    }
                    
                    it("should call output to display error") {
                        expect(networkService.loadNewStoriesCalled).to(beTrue())
                        expect(output.fetchedNewStoriesIdsError).to(beAKindOf(UnitTestError.self))
                    }
                }
            }
        }
    }
}

// MARK: Mocks
extension StoriesInteractorSpec {
    final class MockPresenter: StoriesInteractorOutput {
        var fetchedTopStoriesIds: [Int] = []
        var fetchedTopStoriesIdsError: Error?
        var fetchedBestStoriesIds: [Int] = []
        var fetchedBestStoriesIdsError: Error?
        var fetchedNewStoriesIds: [Int] = []
        var fetchedNewStoriesIdsError: Error?
        var fetchedPosts: [PostModel] = []
        var fetchedPostsError: Error?
        
        func fetchTopStoriesSuccess(ids: [Int]) {
            fetchedTopStoriesIds = ids
        }
        
        func fetchTopStoriesFailed(error: Error) {
            fetchedTopStoriesIdsError = error
        }
        
        func fetchBestStoriesSuccess(ids: [Int]) {
            fetchedBestStoriesIds = ids
        }
        
        func fetchBestStoriesFailed(error: Error) {
            fetchedBestStoriesIdsError = error
        }
        
        func fetchNewStoriesSuccess(ids: [Int]) {
            fetchedNewStoriesIds = ids
        }
        
        func fetchNewStoriesFailed(error: Error) {
            fetchedNewStoriesIdsError = error
        }
        
        func fetchItemsSuccess(_ items: [PostModel]) {
            fetchedPosts = items
        }
        
        func fetchItemsFailed(error: Error) {
            fetchedPostsError = error
        }
    }
}
