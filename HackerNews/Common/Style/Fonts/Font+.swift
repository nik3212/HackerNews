//
//  Font+.swift
//  HackerNews
//
//  Created by Никита Васильев on 11.04.2020.
//  Copyright © 2020 Никита Васильев. All rights reserved.
//

import Foundation

import UIKit

typealias Converter<A> = (A) -> A

infix operator >>>: AdditionPrecedence

func >>> <A>(f1: @escaping Converter<A>, f2: @escaping Converter<A>) -> Converter<A> {
    return { item in f2(f1(item)) }
}

func >>> <UIFont>(font: UIFont, converter: Converter<UIFont>) -> UIFont {
    return converter(font)
}

func newFont(_ font: UIFont, with traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
    guard let descriptor = font.fontDescriptor.withSymbolicTraits(traits) else {
        fatalError("Cannot build font descriptor with traits \(traits)")
    }
    return UIFont(descriptor: descriptor, size: font.pointSize)
}

func newFont(_ font: UIFont, withSize size: CGFloat) -> UIFont {
    let descriptor = font.fontDescriptor
    let newFont = UIFont(descriptor: descriptor, size: size)
    return newFont
}

/// 12 font size.
func tiny(_ font: UIFont) -> UIFont { return newFont(font, withSize: 12) }
/// 13 font size.
func small(_ font: UIFont) -> UIFont { return newFont(font, withSize: 13) }
/// 15 font size.
func normalsize(_ font: UIFont) -> UIFont { return newFont(font, withSize: 15) }
/// 17 font size.
func medium(_ font: UIFont) -> UIFont { return newFont(font, withSize: 17) }
/// 22 font size.
func large(_ font: UIFont) -> UIFont { return newFont(font, withSize: 22) }
/// 34 font size.
func huge(_ font: UIFont) -> UIFont { return newFont(font, withSize: 34) }
