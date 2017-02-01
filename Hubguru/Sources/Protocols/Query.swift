//
//  Query.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

protocol Query {
    var type: RequestType { get }
    var path: String { get }
    var parameters: [String : String] { get }
}
