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
    let icon: UIImage?
    
    /// A `String` value that contains the cell title.
    let title: String
    
    /// A `String` value that contains the right text.
    let info: String?
    
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
    @IBOutlet private var infoLabel: UILabel!
    
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
    /// - Parameter model: A `SettingsCellModel` value that contains the cell data.
    func setup(model: SettingsCellModel) {
        iconView.image = model.icon
        titleLabel.text = model.title
        infoLabel.text = model.info
    }
    
    /// Apply theme to cell.
    /// 
    /// - Parameter theme: A `Theme` value that contains the current application theme.
    func apply(theme: Theme) {
        theme.cell.apply(to: self)
        theme.baseSettingsTitle.apply(to: titleLabel)
        theme.infoSettingsTitle.apply(to: infoLabel)
    }
}
