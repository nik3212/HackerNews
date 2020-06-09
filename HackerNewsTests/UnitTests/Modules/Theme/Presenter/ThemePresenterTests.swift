//
//  ThemePresenterTests.swift
//  HackerNews
//
//  Created by Nikita Vasilev on 27/03/2020.
//  Copyright © 2020 Nikita Vasilev. All rights reserved.
//

import Quick
import Nimble

@testable import HackerNews

final class ThemePresenterTests: QuickSpec {
    override func spec() {
        var view: MockView!
        var router: MockRouter!
        var interactor: MockInteractor!
        var presenter: ThemePresenter!
        var themeManager: MockThemeManager!
        
        beforeEach {
            view = MockView()
            presenter = ThemePresenter()
            router = MockRouter()
            interactor = MockInteractor()
            themeManager = MockThemeManager()
            
            presenter.view = view
            presenter.interactor = interactor
            presenter.router = router
            presenter.themeManager = themeManager
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
            
            it("subscribe to change theme notification") {
                expect(themeManager.addedObserver === presenter).to(beTrue())
            }
        }
        
        describe("check displayed content") {
            beforeEach {
                presenter.viewIsReady()
            }
            
            it("count cells to be equal themes count") {
                expect(presenter.numberOfRows(in: 0)).to(equal(themeManager.themes.count))
            }

            it("table view should contains 1 section") {
                expect(presenter.numberOfSections()).to(equal(1))
            }

            it("display all availiable themes") {
                for (index, theme) in themeManager.themes.enumerated() {
                    let model = presenter.getModel(for: IndexPath(row: index, section: 0))
                    expect(model.title).to(equal(theme.rawValue.localized()))
                    expect(model.isSelected).to(equal(themeManager.theme == theme))
                }
            }

            it("header title should be appearance") {
                expect(presenter.titleForHeader(in: 0)).to(equal(Locale.appearance.localized()))
            }
        }
        
        describe("user change theme") {
            beforeEach {
                presenter.viewIsReady()
            }
            
            it("dismiss view controller when select light theme") {
                presenter.didSelectRow(at: IndexPath(row: 0, section: 0))
                
                expect(router.dismissCalled).to(beTrue())
                expect(themeManager.theme).to(equal(.light))
            }
            
            it("dismiss view controller when select dark theme") {
                presenter.didSelectRow(at: IndexPath(row: 1, section: 0))
                
                expect(router.dismissCalled).to(beTrue())
                expect(themeManager.theme).to(equal(.dark))
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

extension ThemePresenterTests {
    final class MockInteractor: ThemeInteractorInput {
        
    }
    
    final class MockRouter: ThemeRouterInput {
        var dismissCalled: Bool = false
        
        func dismiss() {
            dismissCalled = true
        }
    }
    
    final class MockView: UIViewController, ThemeViewInput {
        var navigationTitle: String?
        var theme: Theme?
        var reloadDataCalled: Bool = false
        
        func setupInitialState(title: String, theme: Theme) {
            self.navigationTitle = title
            self.theme = theme
        }
        
        func reloadData() {
            reloadDataCalled = true
        }
        
        func update(theme: Theme) {
            self.theme = theme
        }
    }
    
    struct Locale {
        static let title: String = "Themes"
        static let appearance: String = "Appearance"
    }
}
