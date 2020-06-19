//
//  CategoryCell.swift
//  HackerNews watchOS WatchKit Extension
//
//  Created by Никита Васильев on 18.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import WatchKit

final class CategoryCell: NSObject {
    
    // MARK: IBOutlets
    @IBOutlet private var titleLabel: WKInterfaceLabel! {
        didSet {
            titleLabel.setText(title)
        }
    }
    
    // MARK: Public Properties
    var title: String = "" {
        didSet {
            titleLabel.setText(title)
        }
    }
}
