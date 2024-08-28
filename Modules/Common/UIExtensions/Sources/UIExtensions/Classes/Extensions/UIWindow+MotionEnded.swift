//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import UIKit

extension UIWindow {
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with _: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
    }
}
