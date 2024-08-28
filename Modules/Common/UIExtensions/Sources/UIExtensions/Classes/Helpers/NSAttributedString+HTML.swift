//
// HackerNews
// Copyright © 2024 Nikita Vasilev. All rights reserved.
//

import UIKit

// swiftlint:disable function_body_length force_unwrapping non_optional_string_data_conversion
public extension NSAttributedString {
    static func html(withBody body: String) -> NSAttributedString {
        // Match the HTML `lang` attribute to current localisation used by the app (aka Bundle.main).
        let bundle = Bundle.main
        let lang = bundle.preferredLocalizations.first
            ?? bundle.developmentLocalization
            ?? "en"

        return (try? NSAttributedString(
            data: """
            <!doctype html>
            <html lang="\(lang)">
            <head>
                <meta charset="utf-8">
                <style type="text/css">
                    /*
                      Custom CSS styling of HTML formatted text.
                      Note, only a limited number of CSS features are supported by NSAttributedString/UITextView.
                    */

                    body {
                        font: -apple-system-body;
                        color: \(UIColor.label.hex);
                    }

                    h1, h2, h3, h4, h5, h6 {
                        color: \(UIColor.label.hex);
                    }

                    a {
                        color: \(UIColor.systemOrange.hex);
                    }

                    li:last-child {
                        margin-bottom: 1em;
                    }
                </style>
            </head>
            <body>
            <span style=\"font-size: 15px;\">
                \(body)
            </span>
            </body>
            </html>
            """.data(using: .utf8)!,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: NSUTF8StringEncoding,
            ],
            documentAttributes: nil
        )) ?? NSAttributedString(string: body)
    }
}

// swiftlint:enable function_body_length force_unwrapping non_optional_string_data_conversion

// MARK: Converting UIColors into CSS friendly color hex string

private extension UIColor {
    var hex: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return String(
            format: "#%02lX%02lX%02lX%02lX",
            lroundf(Float(red * 255)),
            lroundf(Float(green * 255)),
            lroundf(Float(blue * 255)),
            lroundf(Float(alpha * 255))
        )
    }
}

// extension NSAttributedString {
//    func trimmedAttributedString() -> NSAttributedString {
//        let nonNewlines = CharacterSet.whitespacesAndNewlines.inverted
//
//        // Find first non-whitespace character and new line character
//        let startRange = string.rangeOfCharacter(from: nonNewlines)
//
//        // Find last non-whitespace character and new line character.
//        let endRange = string.rangeOfCharacter(from: nonNewlines, options: .backwards)
//        guard let startLocation = startRange?.lowerBound, let endLocation = endRange?.lowerBound else {
//            return self
//        }
//        // Getting range out of locations. This trim out leading and trailing whitespaces and new line characters.
//        let range = NSRange(startLocation...endLocation, in: string)
//        return attributedSubstring(from: range)
//    }
// }
