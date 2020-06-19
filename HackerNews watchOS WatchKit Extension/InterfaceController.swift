//
//  InterfaceController.swift
//  HackerNews watchOS WatchKit Extension
//
//  Created by Никита Васильев on 17.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import WatchKit
import Foundation

final class InterfaceController: WKInterfaceController {

    // MARK: IBOutlets
    @IBOutlet private var tableView: WKInterfaceTable!
    
    // MARK: Private Properties
    private var categories: [String] = ["Top", "Best", "New", "Show", "Ask"]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupTable()
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        self.pushController(withName: "showPosts", context: categories[rowIndex])
    }

    private func setupTable() {
        tableView.setNumberOfRows(categories.count, withRowType: "CategoryCell")
        
        for (index, value) in categories.enumerated() {
            if let row = tableView.rowController(at: index) as? CategoryCell {
                row.title = value
            }
        }
    }
}
