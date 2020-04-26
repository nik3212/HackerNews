//
//  CommentCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 25.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

final class CommentCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var titleLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private var textViewLeadingConstraint: NSLayoutConstraint!
    
    // MARK: Private Properties
    private var theme: Theme?
    
    // MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Public Methods
    
    /// Set model data to the cell.
    ///
    /// - Parameter model: A `CommentModel` value that contains the cell data.
    func setup(model: CommentModel, text: String) {
        guard let username = model.by, let time = model.commentPublishTime() else { return }
        titleLabel.attributedText = theme?.commentTitle(username: username, time: time)
        textView.attributedText = theme?.commentText(text: text)
        updatePadding(with: model.level)
    }
    
    /// Apply theme to cell.
    ///
    /// - Parameter theme: A `Theme` value that contains the current application theme.
    func apply(theme: Theme) {
        self.theme = theme
        theme.postTitle.apply(to: titleLabel)
        theme.postCell.apply(to: self)
        theme.view.apply(to: textView)
        theme.view.apply(to: titleLabel)
    }
    
    // MARK: Private Methods
    
    /// <#Description#>
    ///
    /// - Parameter level: <#level description#>
    private func updatePadding(with level: Int) {
        titleLabelLeadingConstraint.constant = CGFloat(level) * Metrics.padding + Metrics.padding
        textViewLeadingConstraint.constant = CGFloat(level) * Metrics.padding + Metrics.padding
    }
}

// MARK: Metrics
extension CommentCell {
    private struct Metrics {
        static let padding: CGFloat = 15.0
    }
}
