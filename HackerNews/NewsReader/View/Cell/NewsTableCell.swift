//
//  NewsTableCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 25/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

class NewsTableCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var points: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    fileprivate func setup() {
        super.awakeFromNib()
        
        title.textColor = Color.titleCell
        points.textColor = Color.pointsCell
        
        backgroundColor = Color.tableCellBackground
        
        let backgroundCellView = UIView()
        backgroundCellView.backgroundColor = Color.tableSelectedCellBackground
        self.selectedBackgroundView = backgroundCellView
    }
}
