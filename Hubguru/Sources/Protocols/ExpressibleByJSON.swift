//
// ExpressibleByJSON.swift
//
// Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import SwiftyJSON

/// Describes a type that is expressible by JSON.
public protocol ExpressibleByJSON {

	/// Initialize an instance with a JSON representation.
	///
	/// - Parameters:
	///     - json: A JSON representation.
	init(json: JSON)

}
