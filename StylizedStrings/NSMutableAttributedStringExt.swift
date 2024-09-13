//
//  NSMutableAttributedStringExt.swift
//  StylizedStrings
//
//  Created by Yerassyl Zhassuzakhov on 13.09.2024.
//

import UIKit

extension NSMutableAttributedString {
    func bolded(withFont font: UIFont) -> NSMutableAttributedString {
        stylizedByTags(openTag: "<b>", closeTag: "</b>", attributes: [.font: font])
    }

    func strikedThrough(withFont font: UIFont, color: UIColor) -> NSMutableAttributedString {
        return stylizedByTags(
            openTag: "<strike>",
            closeTag: "</strike>",
            attributes: [
                .font: font,
                .foregroundColor: color,
                .strikethroughColor: color,
                .strikethroughStyle: NSUnderlineStyle.single.rawValue
            ]
        )
    }

    func stylizedByTags(openTag: String, closeTag: String, attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let stringLength: Int = string.count

        var rangesToRemove: [NSRange] = []
        var searchRange = NSRange(location: 0, length: stringLength)
        var foundRange = NSRange()
        var firstRange: NSRange?
        var secondRange: NSRange?
        var isOpening: Bool = true

        while searchRange.location < stringLength {
            searchRange.length = stringLength - searchRange.location
            let searchTag = isOpening ? openTag : closeTag
            foundRange = (string as NSString).range(
                of: searchTag,
                options: NSString.CompareOptions.caseInsensitive,
                range: searchRange
            )

            if foundRange.location != NSNotFound {
                isOpening.toggle()
                if firstRange == nil {
                    firstRange = foundRange
                } else if secondRange == nil {
                    secondRange = foundRange
                    let targetRange = mergeTwoRanges(first: firstRange!, second: foundRange)
                    addAttributes(attributes, range: targetRange)
                    rangesToRemove.append(firstRange!)
                    rangesToRemove.append(foundRange)
                    firstRange = nil
                    secondRange = nil
                } else {
                    break
                }
                searchRange.location = foundRange.location + foundRange.length
            } else {
                break
            }
        }
        rangesToRemove.reversed().forEach {
            deleteCharacters(in: $0)
        }
        return self
    }

    func mergeTwoRanges(first firstRange: NSRange, second secondRange: NSRange) -> NSRange {
        let newRange = NSRange(location: firstRange.location + firstRange.length, length: secondRange.location - firstRange.location - firstRange.length)
        return newRange
    }
}
