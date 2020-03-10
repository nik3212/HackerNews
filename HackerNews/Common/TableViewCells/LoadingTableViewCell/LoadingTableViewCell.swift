//
//  LoadingTableViewCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 30/10/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        backgroundColor = Color.tableCellBackground
    }

}
