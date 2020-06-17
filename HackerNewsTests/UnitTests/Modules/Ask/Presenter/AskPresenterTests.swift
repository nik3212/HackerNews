//
//  AskPresenterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 02/05/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble
import NetworkManager
import HNService

@testable import HackerNews

final class AskPresenterTests: QuickSpec {
    override func spec() {
        var view: MockView!
        var router: MockRouter!
        var interactor: MockInteractor!
        var presenter: AskPresenter!
        var themeManager: MockThemeManager!
        
        beforeEach {
            view = MockView()
            presenter = AskPresenter()
            router = MockRouter()
            interactor = MockInteractor()
            themeManager = MockThemeManager()
            
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            presenter.themeManager = themeManager
            
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
                expect(interactor.fetchAskIdsIsCalled).to(beTrue())
                expect(view.userInteractionEnabled).to(beFalse())
            }
            
            it("display loading cells") {
                let viewModel = presenter.getModel(for: IndexPath(row: 0, section: 0))
                expect(viewModel is SkeletonCellViewModel).to(beTrue())
                expect((viewModel as? SkeletonCellViewModel)?.theme).to(equal(themeManager.theme))
            }
        }
        
        describe("fetching ids") {
            context("fetching ids success") {
                beforeEach {
                    presenter.fetchAskSuccess(ids: [1, 2, 3])
                }
                
                it("interactor fetch ids") {
                    expect(interactor.fetchPostsIds).to(equal([1, 2, 3]))
                }
            }
            
            context("fetching ids failed") {
                beforeEach {
                    presenter.fetchAskFailed(error: NetworkError.decodingFailed)
                }
                
                it("should show error") {
                    expect(view.userInteractionEnabled).to(beTrue())
                    expect(view.isReloadDataCalled).to(beTrue())
                    expect(presenter.getEmptyDataSetTitle()).to(equal(Locale.emptyTitle.localized()))
                    expect(presenter.getEmptyDataSetDecription()).toNot(beNil())
                    expect(presenter.getEmptyDataSetImage()).toNot(beNil())
                }
            }
        }
        
        describe("fetching posts") {
            context("fetching posts success") {
                beforeEach {
                    presenter.fetchPostsSuccess([TestData.post])
                }
                
                it("update interface") {
                    expect(view.userInteractionEnabled).to(beTrue())
                    expect(view.isReloadDataCalled).to(beTrue())
                    expect(view.isHideRefreshControlCalled).to(beTrue())
                }
                
                it("display post cells") {
                    let viewModel = presenter.getModel(for: IndexPath(row: 0, section: 0)) as? PostCellViewModel
                    expect(viewModel?.theme).to(equal(themeManager.theme))
                    expect(viewModel?.post.id).to(equal(TestData.post.id))
                    expect(viewModel?.placeholderImage).to(equal(.placeholder))
                }
                
                it("count displayed posts") {
                    expect(presenter.getNumberOfRow()).to(equal(1))
                }
            }
            
            context("fetching posts failed") {
                beforeEach {
                    presenter.fetchPostsFailed(error: NetworkError.decodingFailed)
                }
                
                it("should show error") {
                    expect(view.userInteractionEnabled).to(beTrue())
                    expect(view.isReloadDataCalled).to(beTrue())
                    expect(presenter.getEmptyDataSetTitle()).to(equal(Locale.emptyTitle.localized()))
                    expect(presenter.getEmptyDataSetDecription()).toNot(beNil())
                    expect(presenter.getEmptyDataSetImage()).toNot(beNil())
                }
            }
        }
        
        describe("open modules") {
            context("comments module") {
                beforeEach {
                    presenter.fetchPostsSuccess([TestData.post])
                    presenter.didSelectRow(at: 0)
                }
                
                it("posts should be equal") {
                    expect(router.post?.id).to(equal(TestData.post.id))
                }
            }
        }
        
        describe("refresh stories") {
            beforeEach {
                presenter.refreshStories()
            }
            
            it("show loader on view") {
                expect(view.userInteractionEnabled).to(beFalse())
                expect(view.isReloadDataCalled).to(beTrue())
            }
            
            it("send request") {
                expect(interactor.fetchAskIdsIsCalled).to(beTrue())
            }
        }
        
        describe("prefetch data") {
            beforeEach {
                presenter.fetchAskSuccess(ids: Array(0...50))
                presenter.fetchPostsSuccess([TestData.post])
                presenter.prefetch(at: IndexPath(row: 0, section: 0))
            }
            
            it("send request") {
                expect(interactor.fetchPostsIds).to(equal(Array(1...20)))
                expect(interactor.fetchPostsIds.count).to(equal(20))
            }
        }
        
        describe("change theme") {
            beforeEach {
                presenter.themeDidChange(.light)
            }
            
            it("view handle notification") {
                expect(view.theme).to(equal(.light))
            }
        }
    }
}

// MARK: Mocks
extension AskPresenterTests {
    final class MockInteractor: AskInteractorInput {
        weak var output: AskInteractorOutput!
        var networkService: HNServiceProtocol?
        
        var fetchAskIdsIsCalled: Bool = false
        var fetchPostsIds: [Int] = []
        
        func fetchAskIds() {
            fetchAskIdsIsCalled = true
        }
        
        func fetchPosts(with ids: [Int]) {
            fetchPostsIds = ids
        }
    }
    
    final class MockRouter: AskRouterInput {
        var post: PostModel?
        
        func openCommentsModule(for post: PostModel) {
            self.post = post
        }
    }
    
    final class MockView: UIViewController, AskViewInput {
        var output: AskViewOutput!
        
        var navigationTitle: String?
        var theme: Theme?
        var userInteractionEnabled: Bool?
        var isReloadDataCalled: Bool = false
        var isHideRefreshControlCalled: Bool = false
        
        func setupInitialState(title: String, theme: Theme) {
            self.navigationTitle = title
            self.theme = theme
        }
        
        func setUserInteractorEnabled(to state: Bool) {
            userInteractionEnabled = state
        }
        
        func reloadData() {
            isReloadDataCalled = true
        }
        
        func hideRefreshControl() {
            isHideRefreshControlCalled = true
        }
        
        func update(theme: Theme) {
            self.theme = theme
        }
    }
    
    struct Locale {
        static let title: String = "Ask"
        static let emptyTitle: String = "No stories to show"
    }
}
