//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import DesignKit
import Pulse
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        #if DEBUG
            URLSessionProxyDelegate.enableAutomaticRegistration()
        #endif
        FontFamily.registerAllCustomFonts()
        return true
    }
}
