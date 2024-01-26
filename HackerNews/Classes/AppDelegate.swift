//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import DesignKit
import Pulse
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        URLSessionProxyDelegate.enableAutomaticRegistration()
        FontFamily.registerAllCustomFonts()
        return true
    }
}
