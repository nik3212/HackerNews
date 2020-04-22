//
//  String+Attributed.swift
//  HackerNews
//
//  Created by Никита Васильев on 21.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import UIKit

extension String {
    func attributedString(withLetterSpacing spacing: CGFloat? = nil,
                          lineHeight: CGFloat? = nil,
                          textAlignment: NSTextAlignment? = nil,
                          textColor: UIColor? = nil,
                          font: UIFont? = nil) -> NSAttributedString {
        let att = NSAttributedString.attributes(withLetterSpacing: spacing,
                                                lineHeight: lineHeight,
                                                textAlignment: textAlignment,
                                                textColor: textColor,
                                                font: font)

        return .init(string: self, attributes: att)
    }
}

extension NSAttributedString {
    static func attributes(withLetterSpacing spacing: CGFloat? = nil,
                           lineHeight: CGFloat? = nil,
                           textAlignment: NSTextAlignment? = nil,
                           textColor: UIColor? = nil,
                           font: UIFont? = nil,
                           text: String? = nil) -> [NSAttributedString.Key: Any] {
       var attributes: [NSAttributedString.Key: Any] = [:]
       let style = NSMutableParagraphStyle()

       if let spacing = spacing {
          attributes[.kern] = spacing
       }

       if let lineHeight = lineHeight {
          style.minimumLineHeight = lineHeight
          attributes.updateValue(style, forKey: .paragraphStyle)
       }

       if let textAlignment = textAlignment {
          style.alignment = textAlignment
          attributes.updateValue(style, forKey: .paragraphStyle)
       }

       if let textColor = textColor {
          attributes[.foregroundColor] = textColor
       }

       if let font = font {
          attributes[.font] = font
       }

       return attributes
    }
    
    static func attributedString(from image: UIImage, color: UIColor) -> NSAttributedString {
        let attachment = NSTextAttachment()
        let templateImage = image.withRenderingMode(.alwaysTemplate)
        attachment.image = templateImage.withTint(color: color)
        attachment.bounds = CGRect(x: 0, y: -2, width: image.size.width, height: image.size.height)
        return NSAttributedString(attachment: attachment)
    }
}

func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    // swiftlint:disable force_cast
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    let b = rhs.mutableCopy() as! NSMutableAttributedString
    
    a.append(b)
    
    return a.copy() as! NSAttributedString
    // swiftlint:enable force_cast
}

func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
    // swiftlint:disable force_cast
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    let b = NSMutableAttributedString(string: rhs)
    
    return a + b
    // swiftlint:enable force_cast
}

func + (lhs: String, rhs: NSAttributedString) -> NSAttributedString {
    let a = NSMutableAttributedString(string: lhs)
    // swiftlint:disable force_cast
    let b = lhs.mutableCopy() as! NSMutableAttributedString
    
    return a + b
    // swiftlint:enable force_cast
}

func + (lhs: NSAttributedString, rhs: UIImage) -> NSAttributedString {
    // swiftlint:disable force_cast
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    let b = NSTextAttachment()
    
    b.image = rhs
    
    return a + b
    // swiftlint:enable force_cast
}

func + (lhs: NSAttributedString, rhs: NSTextAttachment) -> NSAttributedString {
    // swiftlint:disable force_cast
    let a = lhs.mutableCopy() as! NSMutableAttributedString
    let b = NSAttributedString(attachment: rhs)

    return a + b
    // swiftlint:enable force_cast
}

func + (lhs: NSTextAttachment, rhs: NSAttributedString) -> NSAttributedString {
    let a = NSAttributedString(attachment: lhs)
    // swiftlint:disable force_cast
    let b = rhs.mutableCopy() as! NSMutableAttributedString

    return a + b
    // swiftlint:enable force_cast
}
