//
//  UIColorExtension.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

/// Think of it as of hexadecimal value, not "unsigned integer of 32bit size"
/// Use hex of size 24 e.g. 0xFFFFFF
typealias HexColor = UInt32

internal extension UIColor {
    
    /// Convenience init for creating color out of hexadecimal value
    ///
    /// - parameter hex:   hexadecimal color value
    /// - parameter alpha: alpha double value
    ///
    /// - returns: Initialized UIColor
    internal convenience init(hex: HexColor, alpha: Double = 1.0) {
        self.init(
            red: CGFloat(hex >> 16 & 0xff) / 0xff,
            green: CGFloat(hex >> 8 & 0xff) / 0xff,
            blue: CGFloat(hex >> 0 & 0xff) / 0xff,
            alpha: CGFloat(alpha)
        )
    }
}
