//
//  StoryTableViewCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 19.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

protocol StoryTableViewCellDelegate: class {
    /// A block object to executed when image tapped.
    func imageDidTapped(cell: StoryTableViewCell)
}

final class StoryTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet private var previewImageView: HNImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var contentStackView: UIStackView!
    
    // MARK: Public Properties
    weak var delegate: StoryTableViewCellDelegate?
    
    // MARK: Private Properties
    private var theme: Theme?
    
    // MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        createRecognizer()
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
    func setup(model: PostModel) {
        if let urlString = model.url {
            previewImageView.setImage(from: URL(string: urlString))
        }
        titleLabel.text = model.title
        descriptionLabel.attributedText = theme?.postDescriptionTitle(score: model.score.map(String.init),
                                                                      username: model.by,
                                                                      time: model.newsPublishTime())
        titleLabel.layer.masksToBounds = false
        descriptionLabel.layer.masksToBounds = false
        contentStackView.layoutIfNeeded()
    }
    
    /// Apply theme to cell.
    ///
    /// - Parameter theme: A `Theme` value that contains the current application theme.
    func apply(theme: Theme) {
        self.theme = theme
        theme.postTitle.apply(to: titleLabel)
        theme.postCell.apply(to: self)
        theme.view.apply(to: titleLabel)
        theme.view.apply(to: descriptionLabel)
    }
    
    // MARK: Private Methods
    private func createRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageDidTap))
        previewImageView.addGestureRecognizer(tap)
    }
}

// MARK: IBAction
extension StoryTableViewCell {
    @objc func imageDidTap() {
        self.delegate?.imageDidTapped(cell: self)
    }
}
