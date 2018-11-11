//
//  NewsTableViewCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 25/08/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit
import NetworkManager

protocol NewsCellDelegate: class {
    func newsCellDidSelectComment(cell: NewsTableViewCell, storyId: Int)
}

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var link: UILabel!
    @IBOutlet weak var commentsView: UIView!
    @IBOutlet weak var score: UILabel!
    
    weak var delegate: NewsCellDelegate?
    
    var story: Item! {
        didSet {
            configure(post: story)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    fileprivate func setup() {
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
    
    fileprivate func configure(post: Item) {
        let date = Date(timeIntervalSince1970: TimeInterval(post.time ?? 0))
        
        title.text = post.title
        info.text = "\(post.score ?? 0) points by \(post.by ?? "Unknown") - \(post.descendants ?? 0) comments - \(Date().timeAgo(from: date))"
        link.text = post.url
        score.text = String(post.score ?? 0)
    }
}

extension NewsTableViewCell {
    @IBAction func openCommentsView(_ sender: UIButton) {
        delegate?.newsCellDidSelectComment(cell: self, storyId: story.id!)
    }
}
