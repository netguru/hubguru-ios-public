//
// ApiClientConfiguration.swift
//
// Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Foundation

/// Describes a configuration of an API client.
public protocol ApiClientConfiguration {

	/// A base URL of an API client.
    var baseURL: URL { get }

	/// A session configuration of an API client.
    var sessionConfiguration: URLSessionConfiguration { get }
	
}
