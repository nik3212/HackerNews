//
//  StoryTableViewCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

final class StoryTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet private var previewImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var linkLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var scoreLabel: UILabel!
    @IBOutlet private var commentButton: UIButton!
    
    // MARK: Public Properties
    
    /// <#Description#>
    var commentAction: (() -> Void)?
    
    // MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
    }
    
    // MARK: Override
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
    
    // MARK: Public Methods
    
    /// Set model data to the cell.
    ///
    /// - Parameter model: A `NewsModel` value that contains the cell data.
    func setup(model: NewsModel) {
        titleLabel.text = model.title
        linkLabel.text = model.url
        scoreLabel.text = String(describing: model.score)
    }
    
    /// Apply theme to cell.
    ///
    /// - Parameter theme: A `Theme` value that contains the current application theme.
    func apply(theme: Theme) {
        theme.cellTwo.apply(to: self)
//        theme.cellTwo.apply(to: self)
//        theme.baseSettingsTitle.apply(to: titleLabel)
//        theme.infoSettingsTitle.apply(to: infoLabel)
    }
}

// MARK: IBAction
extension StoryTableViewCell {
    @IBAction private func commentButtonDidTap(_ sender: UIButton) {
        commentAction?()
    }
}
