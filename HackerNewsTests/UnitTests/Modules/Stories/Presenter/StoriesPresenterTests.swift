//
//  StoriesPresenterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 04/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble
import HNService

@testable import HackerNews

final class StoriesPresenterSpec: QuickSpec {
    override func spec() {
        var view: MockView!
        var router: MockRouter!
        var interactor: MockInteractor!
        var presenter: StoriesPresenter!
        var themeManager: MockThemeManager!
        
        beforeEach {
            view = MockView()
            presenter = StoriesPresenter()
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
            
            it("set segmented control titles") {
                expect(view.titles).to(equal(StoriesPresenter.StoryType.allCases.map { $0.rawValue.localized() }))
            }
            
            it("set theme") {
                expect(view.theme).to(equal(themeManager.theme))
            }
            
            it("subscribe to theme notification") {
                expect(themeManager.addedObserver === presenter).to(beTrue())
            }
            
            it("fetch stories ids") {
                expect(interactor.fetchNewStoriesCalled).to(beTrue())
                expect(view.userInteractionEnabled).to(beFalse())
            }
            
            it("display loading cells") {
                let viewModel = presenter.getModel(for: IndexPath(row: 0, section: 0))
                expect(viewModel is SkeletonCellViewModel).to(beTrue())
                expect((viewModel as? SkeletonCellViewModel)?.theme).to(equal(themeManager.theme))
                expect(presenter.getSkeletonState()).to(equal(.enabled))
            }
        }
        
        describe("fetching ids") {
            context("fetching new stories ids success") {
                beforeEach {
                    presenter.fetchNewStoriesSuccess(ids: Array(0...50))
                }
                
                it("interactor fetch ids") {
                    expect(interactor.postsIds).to(equal(Array(0...19)))
                }
            }
            
            context("fetching new stories ids failed") {
                beforeEach {
                    presenter.fetchNewStoriesFailed(error: UnitTestError())
                }
                
                it("should show error") {
                    expect(view.userInteractionEnabled).to(beTrue())
                    expect(view.isReloadDataCalled).to(beTrue())
                    expect(presenter.getEmptyDataSetTitle()).to(equal(Locale.emptyTitle.localized()))
                    expect(presenter.getEmptyDataSetDecription()).toNot(beNil())
                    expect(presenter.getEmptyDataSetImage()).toNot(beNil())
                    expect(presenter.getSkeletonState()).to(equal(.disabled))
                }
            }
            
            context("fetching best stories ids success") {
                beforeEach {
                    presenter.fetchBestStoriesSuccess(ids: Array(0...50))
                }
                
                it("interactor fetch ids") {
                    expect(interactor.postsIds).to(equal(Array(0...19)))
                }
            }
            
            context("fetching best stories ids failed") {
                beforeEach {
                    presenter.fetchBestStoriesFailed(error: UnitTestError())
                }
                
                it("should show error") {
                    expect(view.userInteractionEnabled).to(beTrue())
                    expect(view.isReloadDataCalled).to(beTrue())
                    expect(presenter.getEmptyDataSetTitle()).to(equal(Locale.emptyTitle.localized()))
                    expect(presenter.getEmptyDataSetDecription()).toNot(beNil())
                    expect(presenter.getEmptyDataSetImage()).toNot(beNil())
                    expect(presenter.getSkeletonState()).to(equal(.disabled))
                }
            }
            
            context("fetching top stories ids success") {
                beforeEach {
                    presenter.fetchTopStoriesSuccess(ids: Array(0...50))
                }
                
                it("interactor fetch ids") {
                    expect(interactor.postsIds).to(equal(Array(0...19)))
                }
            }
            
            context("fetching top stories ids failed") {
                beforeEach {
                    presenter.fetchTopStoriesFailed(error: UnitTestError())
                }
                
                it("should show error") {
                    expect(view.userInteractionEnabled).to(beTrue())
                    expect(view.isReloadDataCalled).to(beTrue())
                    expect(presenter.getEmptyDataSetTitle()).to(equal(Locale.emptyTitle.localized()))
                    expect(presenter.getEmptyDataSetDecription()).toNot(beNil())
                    expect(presenter.getEmptyDataSetImage()).toNot(beNil())
                    expect(presenter.getSkeletonState()).to(equal(.disabled))
                }
            }
        }
        
        describe("open modules") {
            context("comments module") {
                beforeEach {
                    presenter.fetchItemsSuccess([TestData.post])
                    presenter.didSelectRow(at: 0)
                }
                
                it("posts should be equal") {
                    expect(router.post?.id).to(equal(TestData.post.id))
                }
            }
        }
        
        describe("fetching posts") {
            context("fetching posts success") {
                beforeEach {
                    presenter.fetchItemsSuccess([TestData.post])
                }
                
                it("update interface") {
                    expect(view.userInteractionEnabled).to(beTrue())
                    expect(view.isReloadDataCalled).to(beTrue())
                    expect(view.hideRefreshControlCalled).to(beTrue())
                }
                
                it("display post cells") {
                    let viewModel = presenter.getModel(for: IndexPath(row: 0, section: 0)) as? PostCellViewModel
                    expect(viewModel?.theme).to(equal(themeManager.theme))
                    expect(viewModel?.post.id).to(equal(TestData.post.id))
                    expect(viewModel?.placeholderImage).to(equal(.placeholder))
                }
                
                it("count displayed posts") {
                    expect(presenter.numberOfRows()).to(equal(1))
                }
            }
            
            context("fetching posts failed") {
                beforeEach {
                    presenter.fetchItemsFailed(error: UnitTestError())
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
        
        describe("refresh stories") {
            beforeEach {
                presenter.refreshStories()
            }
            
            it("show loader on view") {
                expect(view.userInteractionEnabled).to(beFalse())
                expect(view.isReloadDataCalled).to(beTrue())
                expect(view.scrollContentToTopCalled).to(beTrue())
            }
            
            it("send request") {
                expect(interactor.fetchNewStoriesCalled).to(beTrue())
            }
        }
        
        describe("prefetch data") {
            beforeEach {
                presenter.fetchNewStoriesSuccess(ids: Array(0...50))
                presenter.fetchItemsSuccess([TestData.post])
                presenter.prefetch(at: IndexPath(row: 0, section: 0))
            }
            
            it("send request") {
                expect(interactor.postsIds).to(equal(Array(1...20)))
                expect(interactor.postsIds.count).to(equal(20))
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
        
        describe("segmented control change") {
            beforeEach {
                presenter.viewIsReady()
            }
            
            context("on new stories") {
                beforeEach {
                    presenter.segmentedControlDidChange(to: 0)
                }
                
                it("show loader on view") {
                    expect(view.userInteractionEnabled).to(beFalse())
                    expect(view.isReloadDataCalled).to(beTrue())
                    expect(view.scrollContentToTopCalled).to(beTrue())
                }
                
                it("send request") {
                    expect(interactor.fetchNewStoriesCalled).to(beTrue())
                }
            }
            
            context("on top stories") {
                beforeEach {
                    presenter.segmentedControlDidChange(to: 1)
                }
                
                it("show loader on view") {
                    expect(view.userInteractionEnabled).to(beFalse())
                    expect(view.isReloadDataCalled).to(beTrue())
                    expect(view.scrollContentToTopCalled).to(beTrue())
                }
                
                it("send request") {
                    expect(interactor.fetchTopStoriesCalled).to(beTrue())
                }
            }
            
            context("on best stories") {
                beforeEach {
                    presenter.segmentedControlDidChange(to: 2)
                }
                
                it("show loader on view") {
                    expect(view.userInteractionEnabled).to(beFalse())
                    expect(view.isReloadDataCalled).to(beTrue())
                    expect(view.scrollContentToTopCalled).to(beTrue())
                }
                
                it("send request") {
                    expect(interactor.fetchBestStoriesCalled).to(beTrue())
                }
            }
        }
    }
}

extension StoriesPresenterSpec {
    final class MockInteractor: StoriesInteractorInput {
        var output: StoriesInteractorOutput?
        var networkService: HNServiceProtocol?
        
        var fetchTopStoriesCalled: Bool = false
        var fetchBestStoriesCalled: Bool = false
        var fetchNewStoriesCalled: Bool = false
        var cancleRequestsCalled: Bool = false
        var postsIds: [Int] = []
        
        func fetchTopStories() {
            fetchTopStoriesCalled = true
        }
        
        func fetchBestStories() {
            fetchBestStoriesCalled = true
        }
        
        func fetchNewStories() {
            fetchNewStoriesCalled = true
        }
        
        func fetchPosts(with ids: [Int]) {
            postsIds = ids
        }
        
        func cancleRequests() {
            cancleRequestsCalled = true
        }
    }
    
    final class MockRouter: StoriesRouterInput {
        var actions: [AlertActionModel] = []
        var post: PostModel?
        var storyURL: String?
        
        func openFilterModule(with models: [AlertActionModel]) {
            actions = models
        }
        
        func openCommentsModule(for post: PostModel) {
            self.post = post
        }
        
        func openStories(from url: String) {
            storyURL = url
        }
    }
    
    final class MockView: UIViewController, PostsViewInput {
        var output: PostsViewOutput!
        
        var navigationTitle: String?
        var theme: Theme?
        var userInteractionEnabled: Bool?
        var isReloadDataCalled: Bool = false
        var hideRefreshControlCalled: Bool = false
        var titles: [String]?
        var scrollContentToTopCalled: Bool = false
        
        func setupInitialState(title: String, theme: Theme, titles: [String]?) {
            self.navigationTitle = title
            self.theme = theme
            self.titles = titles
        }
        
        func setLoadingIndicator(to state: Bool) {
            
        }
        
        func setUserInteractorEnabled(to state: Bool) {
            userInteractionEnabled = state
        }
        
        func scrollContentToTop() {
            scrollContentToTopCalled = true
        }
        
        func reloadData() {
            isReloadDataCalled = true
        }
        
        func hideRefreshControl() {
            hideRefreshControlCalled = true
        }
        
        func update(theme: Theme) {
            self.theme = theme
        }
    }
    
    struct Locale {
        static let title: String = "Stories"
        static let emptyTitle: String = "No stories to show"
    }
}
