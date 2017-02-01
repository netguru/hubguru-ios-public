//
// Repository.swift
//
// Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//

import SwiftyJSON

/// Represents a GitHub repository.
public struct Repository: ExpressibleByJSON {

	// MARK: Initializers

	/// Initialize an instance with a JSON representation.
	///
	/// - Parameters:
	///     - json: A JSON rerpresentation of this repository.
	///
	/// - SeeAlso: ExpressibleByJSON
	public init(json: JSON) {
		id = json["id"].intValue
		name = json["name"].stringValue
		isFork = json["fork"].boolValue
	}

	// MARK: Properties

	/// A unique ID of this reposiroty.
	public let id: Int

	/// A name of this repository.
	public let name: String

	/// Whether this repository is a fork.
	public let isFork: Bool

}
