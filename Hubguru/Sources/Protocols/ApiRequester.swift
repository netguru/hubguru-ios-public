//
// ApiRequester.swift
//
// Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Foundation
import RxSwift

/// Describes an API requester.
public protocol ApiRequester {

	/// A configuration of an API requester.
    var configuration: ApiClientConfiguration { get }

	/// An OAuth token of an API requester.
    var oauthToken: String? { get }

}
