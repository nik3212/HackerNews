//
//  CommentsPresenterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 24/04/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

final class CommentsPresenterSpec: QuickSpec {
    override func spec() {
        var view: MockView!
        var router: MockRouter!
        var interactor: MockInteractor!
        var presenter: CommentsPresenter!
        var themeManager: MockThemeManager!
        
        beforeEach {
            view = MockView()
            presenter = CommentsPresenter()
            router = MockRouter()
            interactor = MockInteractor()
            themeManager = MockThemeManager()
            
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            presenter.themeManager = themeManager
            presenter.post = TestData.post
            
            view.output = presenter
            
            interactor.output = presenter
        }
        
        describe("vies is ready") {
            beforeEach {
                presenter.viewIsReady()
            }
            
            it("set navigation title") {
                expect(view.navigationTitle).to(equal(Locale.title.localized()))
            }
            
            it("set theme") {
                expect(view.theme).to(equal(themeManager.theme))
            }
            
            it("subscribe to theme notification") {
                expect(themeManager.addedObserver === presenter).to(beTrue())
            }
            
            it("fetch stories ids") {
                expect(interactor.fetchedCommentsId).toNot(beNil())
            }
                        
            it("display post cell") {
                let viewModel = presenter.getModel(for: IndexPath(row: 0, section: 0)) as? PostCellViewModel
                expect(viewModel).toNot(beNil())
                expect(viewModel?.theme).to(equal(themeManager.theme))
                expect(viewModel?.post.id).to(equal(TestData.post.id))
            }
        }
        
        describe("fetch comment") {
            beforeEach {
                presenter.viewIsReady()
                presenter.fetchCommentsSuccess(TestData.comment)
            }
            
            it("display comments cell") {
                let viewModel = presenter.getModel(for: IndexPath(row: 0, section: 1)) as? CommentCellViewModel
                expect(viewModel).toNot(beNil())
                expect(viewModel?.theme).to(equal(themeManager.theme))
                expect(viewModel?.comment.id).to(equal(TestData.comment.id))
            }
            
            it("success") {
                expect(view.hideActivityIndicatorCalled).to(beTrue())
                expect(view.indertedRowsIndexPaths.count).to(equal(1))
                expect(view.indertedRowsIndexPaths).to(equal([IndexPath(row: 0, section: 1)]))
            }
        }
        
        describe("open modules") {
            context("comments module") {
                beforeEach {
                    presenter.didSelectRow(at: IndexPath(row: 0, section: 0))
                }
                
                it("post urls should be equal") {
                    expect(router.openedURL).to(equal(TestData.post.url))
                }
            }
        }
    }
}

extension CommentsPresenterSpec {
    final class MockInteractor: CommentsInteractorInput {
        weak var output: CommentsInteractorOutput!
        var networkService: HNServiceProtocol?
        
        var fetchedCommentsId: Int?
        
        func fetchComments(for id: Int) {
            fetchedCommentsId = id
        }
    }
    
    final class MockRouter: CommentsRouterInput {
        var openedURL: String?
        
        func openPost(from url: String) {
            self.openedURL = url
        }
    }
    
    final class MockView: UIViewController, CommentsViewInput {
        var output: CommentsViewOutput!
        
        var navigationTitle: String?
        var theme: Theme?
        var reloadDataCalled: Bool = false
        var showActivityIndicatorCalled: Bool = false
        var hideActivityIndicatorCalled: Bool = false
        var indertedRowsIndexPaths: [IndexPath] = []
        
        func setupInitialState(title: String) {
            navigationTitle = title
        }
        
        func displayMessage(text: String) {
            
        }
        
        func reloadData() {
            reloadDataCalled = true
        }
        
        func showActivityIndicator() {
            showActivityIndicatorCalled = true
        }
        
        func hideActivityIndicator() {
            hideActivityIndicatorCalled = true
        }
        
        func insertRows(at indexPaths: [IndexPath]) {
            indertedRowsIndexPaths = indexPaths
        }
        
        func update(theme: Theme) {
            self.theme = theme
        }
    }
    
    struct Locale {
        static let title: String = "Comments"
    }
}
