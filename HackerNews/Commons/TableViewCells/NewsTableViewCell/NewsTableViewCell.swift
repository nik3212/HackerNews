//
//  NewsTableViewCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 25/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var link: UILabel!
    @IBOutlet weak var commentsView: UIView!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    fileprivate func setup() {
        super.awakeFromNib()
        
        title.textColor = Color.titleCell
        info.textColor = Color.infoCell
        link.textColor = Color.linkCell
        commentsView.backgroundColor = Color.commentsViewBackground
        
        score.layer.masksToBounds = true
        score.layer.cornerRadius = 5
        
        backgroundColor = Color.tableCellBackground
        
        let backgroundCellView = UIView()
        backgroundCellView.backgroundColor = Color.tableSelectedCellBackground
        self.selectedBackgroundView = backgroundCellView
    }
}
