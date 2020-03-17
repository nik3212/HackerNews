//
//  CommentTableViewCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 23/10/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit
import NetworkManager

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var commentTextView: UITextView!
    
    @IBOutlet private var usernameLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var timeLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var commentLeadingConstraint: NSLayoutConstraint!
    
    var comment: Comment! {
        didSet {
            configure(comment: comment)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    fileprivate func setup() {
        usernameLabel.textColor = Color.titleCell
        timeLabel.textColor = Color.infoCell
        commentTextView.textColor = Color.comment
        commentTextView.backgroundColor = Color.tableCellBackground
        
        backgroundColor = Color.tableCellBackground
        
        let backgroundCellView = UIView()
        backgroundCellView.backgroundColor = Color.tableSelectedCellBackground
        self.selectedBackgroundView = backgroundCellView
    }
    
    fileprivate func configure(comment: Comment) {
        let date = Date(timeIntervalSince1970: TimeInterval(comment.time ?? 0))
        
        usernameLabel.text = comment.author
        timeLabel.text = Date().timeAgo(from: date)
        commentTextView.text = comment.text?.htmlDecoded
    }
}
