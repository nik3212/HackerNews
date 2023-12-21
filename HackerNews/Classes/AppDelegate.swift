//
// HackerNews
// Copyright © 2023 Nikita Vasilev. All rights reserved.
//

import DesignKit
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FontFamily.registerAllCustomFonts()
        return true
    }
}
