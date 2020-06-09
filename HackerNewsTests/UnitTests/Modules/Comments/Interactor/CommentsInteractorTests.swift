//
//  CommentsInteractorTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

final class CommentsInteractorSpec: QuickSpec {
    override func spec() {
        var interactor: CommentsInteractor!
        var output: MockPresenter!
        var networkService: HNServiceMock!
        
        beforeEach {
            interactor = CommentsInteractor()
            output = MockPresenter()
            networkService = HNServiceMock()
            
            interactor.output = output
            interactor.networkService = networkService
        }
        
        describe("fetch comments") {
            context("success") {
                beforeEach {
                    interactor.fetchComments(for: 132)
                    networkService.loadCommentsCompletion?(TestData.comment)
                }
                
                it("should call output to present comment") {
                    expect(networkService.loadCommentsCalled).to(beTrue())
                    expect(output.comment).toNot(beNil())
                    expect(output.comment?.id).to(equal(TestData.comment.id))
                }
            }
            
            context("fail") {
                beforeEach {
                    interactor.fetchComments(for: 123)
                    networkService.loadCommentsFail?(UnitTestError())
                }
                
                it("should call output to display error") {
                    expect(networkService.loadCommentsCalled).to(beTrue())
                    expect(output.error).to(beAKindOf(UnitTestError.self))
                }
            }
        }
        
    }
}

// MARK: Mocks
extension CommentsInteractorSpec {
    final class MockPresenter: CommentsInteractorOutput {
        var comment: CommentModel?
        var error: Error?
        
        func fetchCommentsSuccess(_ comment: CommentModel) {
            self.comment = comment
        }
        
        func fetchCommentsFail(error: Error) {
            self.error = error
        }
    }
}
