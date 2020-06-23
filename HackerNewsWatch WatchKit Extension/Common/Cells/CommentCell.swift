//
//  CommentCell.swift
//  HackerNewsWatch WatchKit Extension
//
//  Created by Никита Васильев on 21.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import WatchKit

final class CommentCell: NSObject {
    
    // MARK: IBOutlets
    @IBOutlet private var usernameLabel: WKInterfaceLabel!
    @IBOutlet private var commentLabel: WKInterfaceLabel!

    // MARK: Public Methods
    func setup(username: String?, text: String) {
        usernameLabel.setText(username)
        commentLabel.setText(text)
    }
}
