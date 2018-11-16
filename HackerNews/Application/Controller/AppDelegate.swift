//
//  AppDelegate.swift
//  HackerNews
//
//  Created by Никита Васильев on 24/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let resourceURL = Bundle.main.url(forResource: "fabric.apikey", withExtension: nil) {
            do {
                let fabricAPIKey = try String.init(contentsOf: resourceURL)
                let fabricAPIKeyTrimmed = fabricAPIKey.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                Crashlytics.start(withAPIKey: fabricAPIKeyTrimmed)
            } catch {
                print("Failed to initialize Fabric")
            }
        }
        return true
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
