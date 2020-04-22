//
//  StoryTableViewCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import Kingfisher

final class StoryTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet private var previewImageView: HNImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var commentButton: UIButton!
    @IBOutlet private var titleView: UIView!
    
    // MARK: Public Properties
    
    /// A block object to executed when comment tapped.
    var commentAction: (() -> Void)?

    // MARK: Private Properties
    private var theme: Theme?
    
    // MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
    }
    
    // MARK: Override
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        previewImageView.cancel()
    }
    
    // MARK: Public Methods
    
    /// Set model data to the cell.
    ///
    /// - Parameter model: A `NewsModel` value that contains the cell data.
    func setup(model: NewsModel) {
        if let urlString = model.url {
            previewImageView.setImage(from: URL(string: urlString))
        }
        titleLabel.text = model.title
        descriptionLabel.attributedText = theme?.postDescriptionTitle(score: model.score.map(String.init),
                                                                      username: model.by,
                                                                      time: model.newsPublishTime())
    }
    
    /// Apply theme to cell.
    ///
    /// - Parameter theme: A `Theme` value that contains the current application theme.
    func apply(theme: Theme) {
        self.theme = theme
        theme.postTitle.apply(to: titleLabel)
        theme.cellTwo.apply(to: self)
    }
}

// MARK: IBAction
extension StoryTableViewCell {
    @IBAction private func commentButtonDidTap(_ sender: UIButton) {
        commentAction?()
    }
}
