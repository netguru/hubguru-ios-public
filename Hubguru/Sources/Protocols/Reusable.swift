//
//  Reusable.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        return String(describing: type(of: self))
    }
}
