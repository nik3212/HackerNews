//
//  PostCell.swift
//  HackerNewsWatch WatchKit Extension
//
//  Created by Никита Васильев on 20.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import WatchKit
import struct HNService.PostModel

final class PostCell: NSObject {
    
    // MARK: IBOutlets
    @IBOutlet private var titleLabel: WKInterfaceLabel!
    @IBOutlet private var domainLabel: WKInterfaceLabel!
    @IBOutlet private var rateLabel: WKInterfaceLabel!

    // MARK: Public Methods
    func setup(post: PostModel) {
        titleLabel.setText(post.title)
        domainLabel.setText(getHost(from: post.url))
        rateLabel.setText("\(post.score ?? 0)")
    }
}

extension PostCell {
    private func getHost(from urlString: String?) -> String? {
        guard let urlString = urlString else { return nil }
        return URL(string: urlString)?.host
    }
}
