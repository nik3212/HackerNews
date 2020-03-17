//
//  LoadingTableViewCell.swift
//  HackerNews
//
//  Created by Никита Васильев on 30/10/2018.
//  Copyright © 2018 Никита Васильев. All rights reserved.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet private var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func startAnimating() {
        loadingIndicator.startAnimating()
    }
    
    private func setup() {
        backgroundColor = Color.tableCellBackground
    }
}
