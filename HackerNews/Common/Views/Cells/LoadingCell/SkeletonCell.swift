//
//  LoadingCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 23.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation
import Skeleton

class SkeletonCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet private var gradientViews: [GradientContainerView]!
    
    // MARK: Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientViews.forEach {
            $0.backgroundColor = .clear
            $0.gradientLayer.cornerRadius = Metrics.cornerRadius
        }
    }
    
    // MARK: Public Methods
    
    /// Apply theme to cell.
    ///
    /// - Parameter theme: A `Theme` value that contains the current application theme.
    func apply(theme: Theme) {
        theme.postCell.apply(to: self)
        gradientViews.forEach { theme.skeleton.apply(to: $0) }
    }
}

// MARK: GradientsOwner
extension SkeletonCell: GradientsOwner {
    var gradientLayers: [CAGradientLayer] {
        return gradientViews.map { $0.gradientLayer }
    }
}

// MARK: Constants
extension SkeletonCell {
    private enum Metrics {
        static let cornerRadius: CGFloat = 8.0
    }
}
