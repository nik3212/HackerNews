//
//  SettingsTableViewCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 27.03.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

struct SettingsCellModel {
    
    /// An `UIImage` value that contains the cell icon.
    let icon: UIImage
    
    /// A `String` value that contains the cell title.
    let title: String
    
    /// A `String` value that contains the cell description.
    let description: String?
    
    /// A `Type` value that contains the cell type.
    let type: CellType
}

extension SettingsCellModel {
    enum CellType {
        case themes
    }
}

final class SettingsTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet private var iconView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    // MARK: Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyles()
    }
    
    // MARK: Public Methods
    
    /// Set model data to the cell.
    ///
    /// - Parameter model: A `SettingsCellModel` value that contains the cell data.
    func setup(model: SettingsCellModel) {
        iconView.image = model.icon
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
    
    // MARK: Private Methods
    private func setupStyles() {
        
    }
}
