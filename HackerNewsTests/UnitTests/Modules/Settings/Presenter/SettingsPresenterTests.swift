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

final class SettingsPresenterSpec: QuickSpec {
    override func spec() {
        var view: MockView!
        var router: MockRouter!
        var interactor: MockInteractor!
        var presenter: SettingsPresenter!
        var themeManager: MockThemeManager!
        
        beforeEach {
            view = MockView()
            presenter = SettingsPresenter()
            router = MockRouter()
            interactor = MockInteractor()
            themeManager = MockThemeManager()
            
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            presenter.themeManager = themeManager
            
            view.output = presenter
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
        }
        
        describe("settings sections") {
            it("count") {
                expect(presenter.getNumberOfSections()).to(equal(2))
            }
            
            it("title should not be empty") {
                for section in 0..<presenter.getNumberOfSections() {
                    expect(presenter.getTitleForHeader(in: section)).toNot(beNil())
                }
            }
        }
        
        describe("rows") {
            it("theme section") {
                expect(presenter.getNumberOfRows(in: 0)).to(equal(1))
            }
            
            it("other section") {
                expect(presenter.getNumberOfRows(in: 1)).to(equal(2))
            }
            
            it("should return cell for themes section") {
                let viewModel = presenter.getModel(for: IndexPath(row: 0, section: 0))
                
                expect(viewModel).toNot(beNil())
                expect(viewModel?.title).to(equal(Locale.themes.localized()))
            }
            
            it("show return view model for help section") {
                let viewModel = presenter.getModel(for: IndexPath(row: 0, section: 1))
                
                expect(viewModel).toNot(beNil())
            }
            
            it("return nil when index out of range") {
                let viewModel = presenter.getModel(for: IndexPath(row: 10, section: 10))
                expect(viewModel).to(beNil())
            }
        }
        
        describe("open modules") {
            it("show theme vc") {
                presenter.didSelectRow(at: IndexPath(row: 0, section: 0))
                expect(router.showThemeModuleCalled).to(beTrue())
            }
            
            it("show help") {
                presenter.didSelectRow(at: IndexPath(row: 0, section: 1))
                expect(router.openedURL).toNot(beNil())
                expect(router.openedURL).to(equal(URL(string: Constants.Links.feedbackURL)))
            }
            
            it("show rate us") {
                presenter.didSelectRow(at: IndexPath(row: 1, section: 1))
                expect(router.openedURL).toNot(beNil())
                expect(router.openedURL).to(equal(URL(string: Constants.Links.appstoreURL)))
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
extension SettingsPresenterSpec {
    final class MockInteractor: SettingsInteractorInput {
        
    }
    
    final class MockRouter: SettingsRouterInput {
        var showThemeModuleCalled: Bool = false
        var openURLCalled: Bool = false
        var openedURL: URL?
        
        func showThemeModule() {
            showThemeModuleCalled = true
        }
        
        func openURL(_ url: URL) {
            openURLCalled = true
            openedURL = url
        }
    }
    
    final class MockView: UIViewController, SettingsViewInput {
        var output: SettingsViewOutput!
        
        var navigationTitle: String?
        var theme: Theme?
        
        func setupInitialState(title: String, theme: Theme) {
            self.navigationTitle = title
            self.theme = theme
        }
        
        func update(theme: Theme) {
            self.theme = theme
        }
    }
    
    struct Locale {
        static let title: String = "Settings"
        static let themes: String = "Themes"
    }
}
