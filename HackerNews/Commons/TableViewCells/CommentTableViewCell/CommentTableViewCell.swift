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
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var comment: Item! {
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
        commentLabel.textColor = Color.linkCell
        
        backgroundColor = Color.tableCellBackground
        
        let backgroundCellView = UIView()
        backgroundCellView.backgroundColor = Color.tableSelectedCellBackground
        self.selectedBackgroundView = backgroundCellView
    }
    
    fileprivate func configure(comment: Item) {
        usernameLabel.text = comment.by
        commentLabel.text = comment.text
    }
}
