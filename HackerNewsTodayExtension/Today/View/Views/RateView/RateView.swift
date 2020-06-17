//
//  RateView.swift
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
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = label.font.withSize(13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: Override
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineWidth(1.0)
        circleColor.set()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = (frame.size.width - 10) / 2.0
        
        context.addArc(center: center, radius: radius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
        
        context.strokePath()
    }
    
    // MARK: Private Methods
    private func configure() {
        backgroundColor = .clear
        
        addSubview(rateLabel)
        
        NSLayoutConstraint.activate([
            rateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            rateLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            rateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8.0),
            trailingAnchor.constraint(greaterThanOrEqualTo: rateLabel.trailingAnchor, constant: 8.0)
        ])
    }
}
