//
//  InterfaceController.swift
//  HackerNewsWatch WatchKit Extension
//
//  Created by Никита Васильев on 19.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import WatchKit
import Foundation
import HNService

class InterfaceController: WKInterfaceController {

    let service = HNService()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
