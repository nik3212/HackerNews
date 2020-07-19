//
//  SettingsShapshotTests.swift
//  HackerNewsTests
//
//  Created by Никита Васильев on 10.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import FBSnapshotTestCase
    
@testable import HackerNews

// swiftlint:disable force_unwrapping
final class SettingsShapshotTests: FBSnapshotTestCase {
    
    var settingsViewController: SettingsViewController!
    var presenter: SettingsPresenter!
    var themeManager: ThemeManagerProtocol!
    
    private var identifier: String {
        let os = UIDevice.current.systemVersion
        let scale = UIScreen.main.scale
        return "\(os)_\(scale)"
    }
    
    override func setUp() {
        super.setUp()
        
        recordMode = ProcessInfo.processInfo.environment["RECORD_MODE"] == "true"
        
        fileNameOptions = [
            FBSnapshotTestCaseFileNameIncludeOption.OS,
            FBSnapshotTestCaseFileNameIncludeOption.screenScale,
            FBSnapshotTestCaseFileNameIncludeOption.screenSize
        ]
        
        continueAfterFailure = true
        
        settingsViewController = MockContainer().container.resolve(SettingsViewController.self)
        presenter = MockContainer().container.resolve(SettingsPresenter.self,
                                                      argument: settingsViewController!)
        themeManager = MockContainer().container.resolve(ThemeManager.self)
    }
    
    func testThatViewControllerDisplayLightTheme() {
        themeManager.theme = .light
        
        FBSnapshotVerifyView(settingsViewController.view, identifier: identifier, perPixelTolerance: 0.05)
    }
    
    func testThatViewControllerDisplayDarkTheme() {
        themeManager.theme = .dark

        FBSnapshotVerifyView(settingsViewController.view, identifier: identifier, perPixelTolerance: 0.05)
    }
}
// swiftlint:enable force_unwrapping
