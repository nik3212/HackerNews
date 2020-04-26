//
//  AppDelegate.swift
//  HackerNews
//
//  Created by Никита Васильев on 24/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit
//import Fabric
//import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder {
    
    // MARK: Public Properties
    var window: UIWindow?
    let serviceLocatorConfigurator = ServiceLocatorConfigurator()
}

// MARK: UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        if let window = window {
            let rootConfigurator = serviceLocatorConfigurator.assembler.resolver.resolve(RootConfigurator.self)
            rootConfigurator?.installIntoWindow(window)
        }
        
        ThemeManager.shared.theme = Theme(rawValue: SettingsManager.shared.currentTheme ?? "") ?? .dark
        
        loadFabricKeys()
        
        return true
    }
    
    private func loadFabricKeys() {
//        if let resourceURL = Bundle.main.url(forResource: "fabric.apikey", withExtension: nil) {
//            do {
//                let fabricAPIKey = try String.init(contentsOf: resourceURL)
//                let fabricAPIKeyTrimmed = fabricAPIKey.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//                Crashlytics.start(withAPIKey: fabricAPIKeyTrimmed)
//            } catch {
//                print("Failed to initialize Fabric")
//            }
//        }
    }
}

extension AppDelegate {
    static var currentDelegate: AppDelegate {
        // swiftlint:disable force_cast
        return UIApplication.shared.delegate as! AppDelegate
        // swiftlint:enable force_cast
    }
    
    static var currentWindow: UIWindow {
        // swiftlint:disable force_unwrapping
        return currentDelegate.window!
        // swiftlint:enable force_unwrapping
    }
    
    static var currentApplication: UIApplication {
        return UIApplication.shared
    }
}
