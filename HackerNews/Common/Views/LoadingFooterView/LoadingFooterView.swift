//
//  LoadingFooterView.swift
//  HackerNews
//
//  Created by Никита Васильев on 26.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

final class LoadingFooterView: UIView {
    
    // MARK: Private Properties
    private var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: Public Properties
    var isAnimating: Bool = false {
        didSet {
            isAnimating ? activityIndicatorView.stopAnimating() : activityIndicatorView.startAnimating()
        }
    }
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: Private Methods
    private func configure() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: activityIndicatorView.centerXAnchor),
            centerYAnchor.constraint(equalTo: activityIndicatorView.centerYAnchor)
        ])
    }
}
