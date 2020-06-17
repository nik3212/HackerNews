//
//  TodayTableViewCell.swift
//  HackerNewsTodayExtension
//
//  Created by Никита Васильев on 17.06.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

final class RateView: UIView {
    
    // MARK: Public Properties
    
    /// A `String` value that contains the rate.
    var rate: String = "" {
        didSet {
            rateLabel.text = rate
        }
    }
    
    /// An `UIColor` value that contains the circle color.
    var circleColor: UIColor = .systemOrange {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: Private Properties
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
    }
    
    // MARK: Override
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineWidth(1.0)
        circuleColor.set()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = (frame.size.width - 10) / 2.0
        
        context.addArc(center: center, radius: radius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
        
        context.strokePath()
    }
}

final class TopStoryTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var urlLabel: UILabel!
    @IBOutlet private var rateView: RateView!
    
    // MARK: Public Methods
    func setup(title: String, url: String, rate: String) {
        titleLabel.text = title
        urlLabel.text = url
        rateView.rate = rate
    }
}

// MARK: Cell Identifier
extension TopStoryTableViewCell {
    static var cellIdentifier: String {
        return "TopStoryTableViewCell"
    }
}
