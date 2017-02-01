//
//  QueryMock.swift
//  Hubguru
//
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

@testable import Hubguru

class QueryMock: Query {
    let type = RequestType.get
    let path = "/fixture"
    let parameters = [String : String]()
}
