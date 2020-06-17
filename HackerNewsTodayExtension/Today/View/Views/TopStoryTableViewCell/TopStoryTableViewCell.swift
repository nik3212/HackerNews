//
//  TodayTableViewCell.swift
//  HackerNewsTodayExtension
//
//  Created by Никита Васильев on 17.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit
import struct HNService.PostModel

final class TopStoryTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var urlLabel: UILabel!
    @IBOutlet private var rateView: RateView!
    
    // MARK: Public Methods
    func setup(model: PostModel) {
        titleLabel.text = model.title
        urlLabel.text = getHost(from: model.url)
        rateView.rate = "\(model.score ?? 0)"
    }
}

extension TopStoryTableViewCell {
    private func getHost(from urlString: String?) -> String? {
        guard let urlString = urlString else { return nil }
        return URL(string: urlString)?.host
    }
}

// MARK: Cell Identifier
extension TopStoryTableViewCell {
    static var cellIdentifier: String {
        return "TopStoryTableViewCell"
    }
}
